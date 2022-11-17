#!/usr/bin/env bash

# Setup Wiremock responses for Professional Reference Data based on existing Idam users

dir=$(dirname ${0})

echo "Creating wiremock for /refdata/external/v1/organisations/users"
echo

share_case_org_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_ORG_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_ORG_PASSWORD}")"
share_case_org_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_org_code}" | jq -r .id )"

share_case_a_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_A_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_A_PASSWORD}")"
share_case_a_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_a_code}" | jq -r .id )"

share_case_b_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_B_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_B_PASSWORD}")"
share_case_b_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_b_code}" | jq -r .id )"

share_case_org2_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_ORG2_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_ORG2_PASSWORD}")"
share_case_org2_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_org2_code}" | jq -r .id )"

share_case_c_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_C_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_C_PASSWORD}")"
share_case_c_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_c_code}" | jq -r .id )"

share_case_d_code="$(sh ${dir}/idam-user-token.sh "${TEST_LAW_FIRM_SHARE_CASE_D_USERNAME}" "${TEST_LAW_FIRM_SHARE_CASE_D_PASSWORD}")"
share_case_d_id="$(curl --silent --show-error -X GET "${IDAM_URL}/details" -H "accept: application/json" -H "authorization: Bearer ${share_case_d_code}" | jq -r .id )"

curl -X POST \
--data '{
          "request": {
            "method": "GET",
            "urlPath": "/refdata/external/v1/organisations/users"
          },
          "response": {
            "status": 200,
            "headers": {
              "Content-Type": "application/json"
            },
            "jsonBody": {
              "organisationIdentifier": "79ZRSOU",
              "users": [
                {
                  "userIdentifier": "'"${share_case_a_id}"'",
                  "firstName": "Solicitor1",
                  "lastName": "Organisation1",
                  "email": "solicitor1@etorganisation1.com",
                  "idamStatus": "Active"
                },
                {
                  "userIdentifier": "'"${share_case_b_id}"'",
                  "firstName": "Solicitor2",
                  "lastName": "Organisation1",
                  "email": "solicitor2@etorganisation1.com",
                  "idamStatus": "Active"
                },                
                {
                  "userIdentifier": "'"${share_case_org_id}"'",
                  "firstName": "Superuser",
                  "lastName": "Organisation1",
                  "email": "superuser@etorganisation1.com",
                  "idamStatus": "Active"
                }
              ]           
          }
        }
      }' \
http://localhost:4507/__admin/mappings/new

curl -X POST \
--data '{
          "request": {
            "method": "GET",
            "urlPath": "/refdata/external/v1/organisations/users",
            "queryParameters": {
              "status": {
                "equalTo": "Active"
              },
              "returnRoles": {
                "equalTo": "false"
              }
            }            
          },
          "response": {
            "status": 200,
            "headers": {
              "Content-Type": "application/json"
            },
            "jsonBody": {
              "organisationIdentifier": "79ZRSOU",
              "users": [
                {
                  "userIdentifier": "'"${share_case_a_id}"'",
                  "firstName": "Solicitor1",
                  "lastName": "Organisation1",
                  "email": "solicitor1@etorganisation1.com",
                  "idamStatus": "Active"
                },
                {
                  "userIdentifier": "'"${share_case_org_id}"'",
                  "firstName": "Superuser",
                  "lastName": "Organisation1",
                  "email": "superuser@etorganisation1.com",
                  "idamStatus": "Active"
                },
				{
                  "userIdentifier": "'"${share_case_b_id}"'",
                  "firstName": "Solicitor2",
                  "lastName": "Organisation1",
                  "email": "solicitor2@etorganisation1.com",
                  "idamStatus": "Active"
                }                
              ]           
          }
        }
      }' \
http://localhost:4507/__admin/mappings/new


# make responses persistent in Docker volume
curl -X POST http://localhost:4507/__admin/mappings/save
