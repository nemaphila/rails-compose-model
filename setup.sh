#!/bin/bash

mkdir -p tmp/db
mkdir apps
touch Gemfile.lock
docker-compose build --no-cache
docker-compose up -d
docker-compose ps