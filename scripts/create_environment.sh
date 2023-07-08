#!/bin/bash

if [ $# -lt 2 ];then
  return
fi

repo='https://github.com/ihvoschevskiy/envs.git'

git clone -b "$1" "$repo" "$2"

cd "$2"
git remote remove origin
git branch -m master

touch .env

cat <<EOF >> ".gitignore"

# скрипты

.scripts/
run.sh

EOF
