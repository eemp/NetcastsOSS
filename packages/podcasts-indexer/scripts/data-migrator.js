const Promise = require('bluebird');
const { DataSource } = require('loopback-datasource-juggler');

const datasources = require('../server/datasources.json');
const modelDefinition = require('../common/models/podcast.json');
const { name:modelName, properties:modelProperties } = modelDefinition;

const fromDSName = 'es';
const fromDS = new DataSource(fromDSName, datasources[fromDSName]);
const origModel = fromDS.define(modelName, modelProperties);

const toDSName = 'sqlite';
const toDS = new DataSource(toDSName, datasources[toDSName]);
const targetModel = toDS.define(modelName, modelProperties);

origModel.find({limit: 9999}).then(records => {
  console.log(`Found ${records.length} records to migrate...`);
  toDS.autoupdate(modelName).then(result => {
    Promise.mapSeries(records, record => {
      return targetModel.replaceOrCreate(record.toJSON()).then(() => {
        console.log(`Upserted ${record.title || record.name || record.id}`);
      }).catch(err => {
        console.error('Unable to upsert following record:', record);
        console.error('Encountered error:', err);
      });
    });
  });
});
