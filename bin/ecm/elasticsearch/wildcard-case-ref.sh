#!/bin/sh

curl -H "Content-Type: application/json" -X GET "http://localhost:9200/leeds_cases-000001/_search" -d \
'{
  "query": {
    "wildcard": {
      "data.ethosCaseReference": "2*"
    }
  },
  "_source": false
}' | jq --color-output