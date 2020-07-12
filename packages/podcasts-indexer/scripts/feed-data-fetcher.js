const _ = require('lodash');
const _h = require('highland');
// const heapdump = require('heapdump');
const moment = require('moment');
const Parser = require('rss-parser');
const Promise = require('bluebird');
const { DataSource } = require('loopback-datasource-juggler');

const datasources = require('../server/datasources.json');
const modelDefinition = require('../common/models/podcast.json');
const { name:modelName, properties:modelProperties, settings: modelSettings } = modelDefinition;

const totalBatchSize = parseInt(process.env.BATCH_SIZE || 10000, 10);

const dsName = process.env.DS || 'mysql';
const DS = new DataSource(dsName, datasources[dsName]);
const model = DS.define(modelName, modelProperties, modelSettings);

const CONCURRENCY = 10;

// logMemoryUsage();

const enhancePodcastWithFeedData_h = _h.wrapCallback(enhancePodcastWithFeedData);

const stats = {
  updates: 0,
  failures: 0,
};
fetchPodcasts().then(podcasts => {
  console.log(`Fetched ${podcasts.length} total podcasts last modified between
  ${_.first(podcasts).last_modified_timestamp} to ${_.last(podcasts).last_modified_timestamp}.`);
  stats.total = podcasts.length;

  return _h(podcasts)
    .map(_h.wrapCallback(enhancePodcastWithFeedData))
    .parallel(CONCURRENCY)
    .each((res) => res ? stats.updates++ : stats.failures++)
    .collect()
    .toPromise(Promise)
  ;
}).catch(err => {
  console.error('Unable to fetch all feeds and complete.', err);
  console.log('Processed: ', stats);
}).then(() => {
  console.log('Finished the batch... Processed: ', stats);
  process.exit(0);
});

function fetchPodcasts() {
  return model.find({ limit: totalBatchSize, order: ['last_modified_timestamp ASC', 'popularity ASC'] });
}

function enhancePodcastWithFeedData(podcast, callback) {
  const { id } = podcast;

  return Promise.resolve(fetchFeedData(podcast)).then(
    podcastInfoFromFeed => {
      if(_.isEmpty(podcastInfoFromFeed)) {
        return Promise.resolve();
      }

      return model.upsertWithWhere({ id }, podcastInfoFromFeed);
    }
  ).catch(err => {
    console.error(`Unable to enhancePodcastWithFeedData for ${podcast.url}...`, err);
  }).asCallback(callback);
}

function fetchFeedData(podcast) {
  const { feed, id } = podcast;
  if(!feed || !id) {
    // console.error(`Missing required params to obtain feed data: feed=${feed}, id=${id}. Skipping...`);
    return Promise.resolve();
  }

  const parser = new Parser({
    headers: { 'Accept': '*/*', 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0' },
  });
  return parser.parseURL(feed).catch(err => {
    // console.error(`Unable to fetch feed data for ${feed} due to following err: `, err);
    return Promise.resolve();
  })
  .then(feedData => {
    const lastUpdated = _.get(feedData, 'items.0.pubDate')
      ? moment(_.get(feedData, 'items.0.pubDate')).toDate()
      : undefined;
    return {
      artworkOrig: _.get(feedData, 'image.url'),
      description: _.get(feedData, 'description'),
      episodes: {
        count: _.size(_.get(feedData, 'items')),
      },
      last_modified_timestamp: new Date(),
      last_updated: lastUpdated,
    };
  });
}

function logMemoryUsage() {
  setInterval(() => {
    const used = process.memoryUsage();
    console.log(`rss ${Math.round(used.rss / 1024 / 1024 * 100) / 100} MB`);
    // heapdump.writeSnapshot(Date.now() + '.heapsnapshot');
  }, 15000);
}
