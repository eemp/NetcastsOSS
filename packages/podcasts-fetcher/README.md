# Hear2Learn: Podcasts Fetcher

Dart does not have a sufficiently mature Elastic client. Therefore,
we currently have bash/node scripts to interface with and push podcast
records to Elasticsearch.

## Usage

1. Create the index

```
ES_SERVER=http://localhost:9200 \
ES_INDEX=hear2learn \
bash scripts/create-index.sh
```

2. Push mappings

```
ES_SERVER=http://localhost:9200 \
ES_INDEX=hear2learn \
bash scripts/push-mappings.sh
```

3. Index initial documents based on iTunes data (top 10k?, ~5 min)

```
ES_SERVER=http://localhost:9200 \
ES_INDEX=hear2learn \
node index-itunes-data.js
```

4. Index additional data from feeds

```
ES_SERVER=http://localhost:9200 \
ES_INDEX=hear2learn \
node index-feed-data.js
```

## Custom Podcasts

* [Rated G for Gamers](http://ratedgforgamers.libsyn.com/rss)
* [RubyApps Insights](https://www.rubensteintech.com/feed-RubyApps-Insights.rss)
