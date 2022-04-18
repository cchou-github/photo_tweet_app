#!/bin/bash
set -e

rm -f /var/www/photo_tweet_app/tmp/pids/server.pid

exec "$@"