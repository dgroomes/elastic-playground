#!/usr/bin/env bash
# Delete all the ZIP areas data from the Elasticsearch instance. Specifically, we are deleting from the "index" called
# "zip_areas". In SQL we have "tables", in MongoDB we have "collections", in Kafka we have "topics" and in Elasticsearch
# we have "indexes".

origin="[::1]:9200"

set -eu

curl -X DELETE --url "$origin/zip_areas?pretty"
echo "Deleted! Poof, it's all gone."
