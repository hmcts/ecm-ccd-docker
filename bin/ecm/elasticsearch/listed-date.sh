#!/bin/sh

curl -H "Content-Type: application/json" -X GET "http://localhost:9200/leeds_cases-000001/_search" -d \
'{
  "query": {
    "range": {
      "data.hearingCollection.value.hearingDateCollection.value.listedDate": {
        "from": "2021-06-01",
        "to": "2021-06-06"
      }
    }
  },
  "_source": {
    "includes": [ "jurisdiction","data.ethosCaseReference", "data.hearingCollection.value.hearingDateCollection" ]
  }
}' | jq --color-output