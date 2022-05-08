#!/usr/bin/env bash
# Query ZIP areas from the Elasticsearch instance.

origin="[::1]:9200"

curl -X GET \
 --url "$origin/zip_areas/_search?pretty" \
 --header 'Content-Type: application/json' --data '
{
  "query": {
    "match_all": { }
  }
}
'
