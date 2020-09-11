#!/bin/bash

docker build --tag hello-world:latest .
docker run --publish 4000:4000 --name hello-world-example hello-world:latest
