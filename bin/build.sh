#!/usr/bin/env bash

docker build -t outlandish/bedrock -f docker/wordpress/Dockerfile .
docker build -t outlandish/bedrock-web -f docker/web/Dockerfile .