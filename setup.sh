#!/bin/bash

mkdir -p db-volume
touch Gemfile.lock
docker-compose build --no-cache
docker-compose up -d
docker-compose ps