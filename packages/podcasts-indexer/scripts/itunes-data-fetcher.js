const _ = require('lodash');
const Bottleneck = require('bottleneck');
const Promise = require('bluebird');
const request = require('axios');
const { DataSource } = require('loopback-datasource-juggler');

const datasources = require('../server/datasources.json');
const modelDefinition = require('../common/models/podcast.json');
const { name:modelName, properties:modelProperties, settings: modelSettings } = modelDefinition;

const offset = parseInt(process.env.OFFSET || 0, 10);
const totalBatchSize = parseInt(process.env.BATCH_SIZE || 10000, 10);

const dsName = process.env.DS || 'mysql';
const DS = new DataSource(dsName, datasources[dsName]);
const model = DS.define(modelName, modelProperties, modelSettings);


const ITUNES_SEARCH_ENDPOINT = 'https://itunes.apple.com/search';
const COUNTRY_US = 'us';
const LANG_EN_US = 'en_us';
const PODCAST_MEDIA = 'podcast';
const PODCAST_TERM = 'podcast';

const RESULTS_SET_SIZE = 200;

const limiter = new Bottleneck({
  reservoir: 20,
  reservoirRefreshAmount: 20,
  reservoirRefreshInterval: 60 * 1000,

  maxConcurrent: 1,
  minTime: 3000,
});
const limitedFetcher = limiter.wrap(fetchPodcasts);

const offsets = Array.from(Array(totalBatchSize/RESULTS_SET_SIZE).keys()).map(n => offset + (RESULTS_SET_SIZE*n));
Promise.mapSeries(offsets, offset => {
  return limitedFetcher(offset).then(response => {
    const { data: { results } } = response;
    const records = results.map(getRecordFromResult.bind(null, offset));
    return Promise.mapSeries(records, record => upsertPodcastRecord(record));
  }).then(() => {
    console.log(`Processed 200 items with offset=${offset}.`);
  });
}).then(() => {
  console.log('Finished fully processing batch.');
  limiter.disconnect();
  process.exit(0);
}).catch(err => {
  console.error('Unable to completely fetch and index podcasts: ', err);
  process.exit(-1);
});

function fetchPodcasts(offset) {
  const params = {
    country: COUNTRY_US,
    entity: PODCAST_MEDIA,
    lang: LANG_EN_US,
    limit: RESULTS_SET_SIZE,
    media: PODCAST_MEDIA,
    offset: offset,
    term: PODCAST_TERM,
  };
  return request.get(ITUNES_SEARCH_ENDPOINT, { params });
}

function getRecordFromResult(scanOffset, result, idx) {
  return {
    artist: {
      id: result.artistId,
      name: result.artistName,
    },
    artwork30: result.artworkUrl30,
    artwork60: result.artworkUrl60,
    artwork100: result.artworkUrl100,
    artwork600: result.artworkUrl600,
    episodes: {
      count: result.trackCount,
    },
    feed: result.feedUrl,
    genres: result.genres.map((genre, index) => ({
      id: _.get(result, `genreIds[${index}]`),
      name: genre,
    })),
    id: result.trackId,
    last_modified_date: new Date(),
    name: result.trackName,
    popularity: scanOffset + idx,
    primary_genre: {
      id: _.get(result, 'genreIds[0]'),
      name: _.get(result, 'genres[0]'),
    },
    release_date: result.releaseDate,
    type: PODCAST_MEDIA,
  };
}

function upsertPodcastRecord(record) {
  return Promise.resolve(model.replaceOrCreate(record))
    .reflect();
}
