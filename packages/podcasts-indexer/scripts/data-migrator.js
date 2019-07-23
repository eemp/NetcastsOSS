const Promise = require('bluebird');
const { DataSource } = require('loopback-datasource-juggler');

const datasources = require('../server/datasources.json');
const modelDefinition = require('../common/models/podcast.json');
const { name:modelName, properties:modelProperties } = modelDefinition;

const fromDSName = process.env.FROM_DS;
const toDSName = process.env.TO_DS;
const strategyName = process.env.STRATEGY;
if(!fromDSName || !toDSName) {
  console.error('Usage: FROM_DS=sqlite TO_DS=mysql node data-migrator.js');
  process.exit(-1);
}

const fromDS = new DataSource(fromDSName, datasources[fromDSName]);
const origModel = fromDS.define(modelName, modelProperties);

const toDS = new DataSource(toDSName, datasources[toDSName]);
const targetModel = toDS.define(modelName, modelProperties);

const STRATEGIES = {
  default: replaceOrCreateRecords,
  create: createRecords,
  upsert: replaceOrCreateRecords,
};
const strategy = STRATEGIES[strategyName] || STRATEGIES.default;

origModel.find({limit: 9999}).then(results => {
  const records = results.map(result => result.toJSON());
  console.log(`Found ${records.length} records to migrate...`);
  toDS.autoupdate(modelName).then(result => {
    strategy(records);
  });
});

function createRecords(records) {
  return targetModel.create(records).then(res => {
    console.log(`Finished batch creating ${res.length} records.`);
    process.exit(0);
  }).catch(err => {
    console.error('Unable to batch create all records due to following error:', err);
    process.exit(-1);
  });
}

function replaceOrCreateRecords(records) {
  return Promise.mapSeries(records, record => {
    return targetModel.replaceOrCreate(record).then(() => {
      console.log(`Upserted ${record.title || record.name || record.id}`);
    }).catch(err => {
      console.error('Unable to upsert following record:', record);
      console.error('Encountered error:', err);
    });
  });
}
