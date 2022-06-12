#!/usr/bin/env bash

bundle install
bundle exec rake db:migrate
bundle exec rake db:seed
rails s -b 0.0.0.0