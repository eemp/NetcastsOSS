#!/bin/sh

[ -z "$ES_SERVER" ] && echo "Need to set ENV.ES_SERVER" && exit 1
[ -z "$ES_INDEX" ] && echo "Need to set ENV.ES_INDEX" && exit 1

curl -XPOST $ES_SERVER/$ES_INDEX/podcast/_update_by_query?conflicts=proceed -H 'Content-Type: application/json' -d '{ "query": { "match_all": {} } }'
