const _ = require('lodash');
const moment = require('moment');
const Parser = require('rss-parser');
const Promise = require('bluebird');

const { client, indexRecord } = require('./elastic');

const PODCAST_MEDIA = 'podcast';
const ES_SCROLL_DURATION = '30s';
const ES_SCROLL_SIZE = 1000;

const parser = new Parser({
  headers: { 'Accept': '*/*', 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.71 Safari/537.36 Edge/12.0' },
});

fetchAllPodcasts().then(podcasts => {
  console.log(`Fetched ${podcasts.length} total podcasts.`);
  return Promise.mapSeries(podcasts, (podcast, index) => {
    return Promise.resolve(fetchAndIndexFeedData(podcast)).reflect().then(result => {
      if(index > 0 && (index % 100 === 0 || index === podcasts.length - 1)) {
        console.log(`Processed ${index} total items...`);
      }

      if(!result.isFulfilled()) {
        console.warn('Unable to process podcast feed: ', podcast.feed);
        console.warn('Encountered following error: ', result.reason().message);
        return Promise.resolve();
      }

      return result.value();
    });
  });
}).catch(err => {
  console.error('Unable to fetch all feeds and complete.', err);
}).then(() => {
  client.close();
});

function fetchAllPodcasts() {
  return client.search({
    index: process.env.ES_INDEX,
    scroll: ES_SCROLL_DURATION,
    size: ES_SCROLL_SIZE,
    type: PODCAST_MEDIA,
  }).then(scrollUntilDone);
}

function fetchAndIndexFeedData(hit) {
  const { _source:podcast } = hit;
  const { feed } = podcast;
  if(!feed) {
    return Promise.resolve();
  }

  return parser.parseURL(feed).then(feedData => {
    const lastModifiedDate = _.get(feedData, 'items.0.pubDate')
      ? moment(_.get(feedData, 'items.0.pubDate'))
      : undefined;
    const updatedPodcast = _.assign({
      artworkOrig: _.get(feedData, 'image.url'),
      description: _.get(feedData, 'description'),
      last_modified_date: lastModifiedDate && lastModifiedDate.isValid()
        ? lastModifiedDate.format()
        : undefined,
      type: PODCAST_MEDIA,
    }, podcast);
    return indexRecord(updatedPodcast);
  });
}

function scrollUntilDone(response, collector=[]) {
  return new Promise((resolve, reject) => {
    const { hits: { hits, total }, _scroll_id:scrollId } = response;
    collector = collector.concat(hits);
    if(total != collector.length) {
      client.scroll({scrollId, scroll: ES_SCROLL_DURATION}).then(response => {
        resolve(scrollUntilDone(response, collector))
      }).catch(err => reject(err));
    }
    else {
      resolve(collector);
    }
  });
}
