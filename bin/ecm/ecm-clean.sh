#!/usr/bin/env bash

./ccd compose stop
docker rm $(docker ps -a -q)
docker volume prune