#!/bin/bash
bundle exec jekyll serve --livereload &
sleep 2
start http://localhost:4000
