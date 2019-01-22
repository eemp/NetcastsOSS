#!/bin/sh

[ -z "$ES_SERVER" ] && echo "Need to set ENV.ES_SERVER" && exit 1
[ -z "$ES_INDEX" ] && echo "Need to set ENV.ES_INDEX" && exit 1

curl -XPOST $ES_SERVER/$ES_INDEX/_close
curl -XPUT $ES_SERVER/$ES_INDEX/_settings -H 'Content-Type: application/json' -d @etc/settings.json
curl -XPOST $ES_SERVER/$ES_INDEX/_open
