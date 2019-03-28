#! /usr/bin/env bash

docker run -it -v "$PWD/config/aws:/root/.aws" -v "$PWD/config/okta:/root/.okta" bourkey/dev-tools:latest