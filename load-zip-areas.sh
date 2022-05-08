#!/usr/bin/env bash
# Load the ZIP area data into Elasticsearch.
#
# ZIP area data is defined in the `zips.jsonl` file. This script will create an Elastisearch "document" for each line
# in the file. Each line represents a ZIP area. A ZIP are is made up of
#
# 1. ZIP code
# 2. City name
# 3. The geographic location in Latitude/Longitude
# 4. ZIP population
# 5. State abbreviation
#
# For example, here is the JSON record for the ZIP area with ZIP code 10005 in New York City, New York:
#
# { "_id" : "10005", "city" : "NEW YORK", "loc" : [ -74.00834399999999, 40.705649 ], "pop" : 202, "state" : "NY" }

# Bash trick to get the directory containing the script. See https://stackoverflow.com/a/246128
project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

set -eu

zips_file="$project_dir/zips.jsonl"
origin="[::1]:9200"
limit=1000

# Read from the ZIP areas JSON file and upload to the Elasticsearch instance.
function load() {
  echo "⏳ Loading $limit ZIP area records into Elasticsearch..."
  local idx=0
  while read -r zip_area_json && (( $idx < $limit )) ; do
    idx=$((idx + 1))

    curl -X POST --show-error --silent --output /dev/null  \
      --url "$origin/zip_areas/_doc?pretty" \
      --header 'Content-Type: application/json' --data "$zip_area_json"

  done < "$zips_file"

  echo "✨ Done."
}

load
