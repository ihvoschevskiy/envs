#!/bin/bash

if [[ $1 = "" ]]; then
  echo "Необходимо ввести commit message"
  exit 1;
fi

current_branch="$(git rev-parse --abbrev-ref HEAD)"

npm run prettier
npm run lint

read -p "Продолжить? (y/n): " confirm && [[ $confirm == [yY] ]] || exit 1

git add .
git commit -m $1
git checkout dev
git merge $current_branch

read -p "Удалить $current_branch? (y/n): " confirm && [[ $confirm == [yY] ]] || exit 1

git br -d $current_branch
