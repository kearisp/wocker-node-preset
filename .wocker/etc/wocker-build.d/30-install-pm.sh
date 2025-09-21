#!/bin/sh

set -e

case "$PACKAGE_MANAGER" in
    "pnpm")
        npm install -g pnpm
        ;;
esac
