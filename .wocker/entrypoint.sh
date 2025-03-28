#!/bin/bash

set -e

if [ "$PACKAGE_MANAGER" = "npm" ]; then
    npm install --quiet --no-progress;
else
    yarn install --silent;
fi

exec "$@"
