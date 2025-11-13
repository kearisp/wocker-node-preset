#!/usr/bin/env sh

set -e

if grep -q "Alpine" /etc/os-release; then
    apk update
else
    apt-get update -y
fi

