#!/usr/bin/env bash
# Query ZIP areas from the Elasticsearch instance.

origin="[::1]:9200"

set -eu

# Bash trick to get the directory containing the script. See https://stackoverflow.com/a/246128
project_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Prompt the Bash user to choose an Elasticsearch query from any of the queries in the "queries/" directory.
function choose_query() {

  # Note: It's necessary to set IFS so that files with spaces in the name are accommodated.
  # See: https://stackoverflow.com/a/9449633
  IFS=$'\n'
  local query_files=( $(ls "$project_dir/queries") )
  unset IFS

  PS3='Choose Elasticsearch query: '
  select opt in "${query_files[@]}"
  do
    echo "${project_dir}/queries/${opt}"
    exit
  done
}

function execute_query() {
  local query_file=$(choose_query)

  curl -X GET \
   --url "$origin/zip_areas/_search?pretty" \
   --header 'Content-Type: application/json' --data "@${query_file}"
}

execute_query
