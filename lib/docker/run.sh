#!/bin/bash

# Remove existing server.pid if present
rm ./tmp/pids/server.pid

# Ensure bundler gem is installed
gem install bundler

# Update ruby gem bundle
bundle

# Prep or update db
bundle exec rake db:create db:migrate db:seed

# Wait for DB server
sleep 2

# Execute run command
exec $@
