#!/usr/bin/env bash

env=$1
if [[ -z $1 ]]; then
    env="beta"
fi

# Increase Node.js heap size to prevent OOM during Vite build
# Default: 16384 MB (16 GB), can be overridden via NODE_MAX_OLD_SPACE_SIZE env var
MAX_OLD_SPACE="${NODE_MAX_OLD_SPACE_SIZE:-16384}"
if [ -z "${NODE_OPTIONS:-}" ] || ! echo "$NODE_OPTIONS" | grep -q -- "--max-old-space-size="; then
  export NODE_OPTIONS="--max-old-space-size=$MAX_OLD_SPACE ${NODE_OPTIONS:-}"
fi
echo "Using NODE_OPTIONS: ${NODE_OPTIONS}"

npm run build

cp -r build/* ../public/
