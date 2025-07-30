#!/bin/bash

if [ "$NODE_VERSION" != "" ] && [ "$NODE_VERSION" != "none" ]; then
    if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
        if [ "$PACKAGE_MANAGER" = "npm" ]; then
            if [ -f "package-lock.json" ]; then
                npm ci --quiet --no-progress
            else
                npm install --quiet --no-progress
            fi
        else
            yarn install --silent;
        fi
    fi
fi
