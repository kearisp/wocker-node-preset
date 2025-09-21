#!/bin/sh

if [ "$NODE_VERSION" = "" ] || [ "$NODE_VERSION" = "none" ]; then
    echo "No node version found"
    exit 0
fi

echo "PACKAGE_MANAGER: $PACKAGE_MANAGER";

if [ -f "package.json" ] && [ ! -d "node_modules" ]; then
    case "$PACKAGE_MANAGER" in
        "npm")
            if [ -f "package-lock.json" ]; then
                npm ci --quiet --no-progress
            else
                npm install --quiet --no-progress
            fi
            ;;
        "pnpm")
            if [ -f "pnpm-lock.yaml" ]; then
                pnpm install --frozen-lockfile --silent
            else
                pnpm install --silent
            fi
            ;;
        "yarn")
            yarn install --silent
            ;;
        *)
            echo "Error: Invalid package manager name '$PACKAGE_MANAGER'"
            exit 1
            ;;
    esac
fi
