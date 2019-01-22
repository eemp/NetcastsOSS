#!/bin/sh

[ -z "$ES_SERVER" ] && echo "Need to set ENV.ES_SERVER" && exit 1
[ -z "$ES_INDEX" ] && echo "Need to set ENV.ES_INDEX" && exit 1

curl -XPUT $ES_SERVER/$ES_INDEX/_mapping/podcast -H 'Content-Type: application/json' -d @etc/mappings.json
