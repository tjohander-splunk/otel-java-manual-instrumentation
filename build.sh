#!/bin/sh

# TODO: Set a container repo name as a variable
REPO_NAME='foo'
IMAGE_NAME=
docker build . -f dockerfile-java -t otel-java-manual-insturmentation
docker tag splk-java ${REPO_NAME}/${IMAGE_NAME}
docker push ${REPO_NAME}/${IMAGE_NAME}