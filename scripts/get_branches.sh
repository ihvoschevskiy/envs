#!/bin/bash

cd "$1"

branches=$(git branch -r)

echo "$branches"
