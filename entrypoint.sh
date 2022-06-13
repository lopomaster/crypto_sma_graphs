#!/usr/bin/env bash

bundle install
bundle exec rails db:create
bundle exec rake db:migrate
bundle exec rake db:seed

bundle exec crono -e development

rails s -b 0.0.0.0