const Promise = require('bluebird');
const { DataSource } = require('loopback-datasource-juggler');

const datasources = require('../server/datasources.json');
const modelDefinition = require('../common/models/podcast.json');
const { name:modelName, properties:modelProperties, settings: modelSettings } = modelDefinition;

const dsName = process.env.DS || 'mysql';
const DS = new DataSource(dsName, datasources[dsName]);
const model = DS.define(modelName, modelProperties, modelSettings);

DS.autoupdate(modelName).then(() => {
  console.log(`Autoupdate ${dsName} based on model.`);
  process.exit(0);
}).catch(err => {
  console.error('Unable to migrate podcasts data, encountered: ', err.message);
  process.exit(-1);
});
