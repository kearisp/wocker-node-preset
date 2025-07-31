#!/bin/bash

set -e

ws-run-hook init

exec "$@"
