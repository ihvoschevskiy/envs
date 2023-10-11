#!/bin/bash

PS3='Please enter your choice: '
options=("Add" "Commit" "Math" "Remove .gitkeep" "Quit")

select opt in "${options[@]}"
do
  case $REPLY in
    1)
        sh ./.scripts/add.sh
        break
        ;;
    2)
        sh ./.scripts/commit.sh
        break
        ;;
    3)
        sh ./.scripts/math.sh
        break
        ;;
    4)
        sh ./.scripts/rm_gitkeep.sh
        break
        ;;
    5)
        exit 1
        break
        ;;
    *) echo "invalid option $REPLY";;
  esac
done
