#!/bin/sh

set -e

if [ -f /minesweeper/tmp/pids/server.pid ]; then
    rm /minesweeper/tmp/pids/server.pid
fi

bundle exec rails s -b 0.0.0.0