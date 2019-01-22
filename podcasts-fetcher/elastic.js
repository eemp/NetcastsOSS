const elasticsearch = require('elasticsearch');

const ES_SERVER = process.env.ES_SERVER;
const ES_INDEX = process.env.ES_INDEX;

if(!ES_SERVER) {
  throw new Error('Need to set process.env.ES_SERVER');
}
if(!ES_INDEX) {
  throw new Error('Need to set process.env.ES_INDEX');
}

const client = new elasticsearch.Client({
  host: ES_SERVER,
});

function indexRecord(record) {
  return client.index({
    id: record.id,
    index: process.env.ES_INDEX,
    type: record.type,
    body: record,
  }).catch(err => {
    console.error('Unable to push record: ', JSON.stringify(record));
    console.error('Encountered following error: ', err);
    return Promise.resolve();
  });
}

module.exports = {
  client,
  indexRecord,
};
