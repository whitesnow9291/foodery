#!/bin/bash

bundle check || bundle install

bundle exec puma -C config/puma-develop.rb
