#!/bin/bash

function create {
  if ! [[ -d "./src/$1/$2" ]];then 
    mkdir "./src/$1/$2"
  fi

  if ! [[ -f "./src/$1/$2/$2.tsx" ]]; then
cat <<EOF > "./src/$1/$2/$2.tsx"
import './$2.css'
import React, { FC } from 'react'

export const $2: FC = () => {
  return (
    <>
    </>
  )
}
EOF
  fi

  if ! [[ -f "./src/$1/$2/$2.css" ]]; then
    touch "./src/$1/$2/$2.css"
  fi

}

function parseInput() {
  for((i=1;i<=$#;i++)); do
    ip="${!i}"

    if [[ $ip = "-c" ]]; then
      ((i++))
      for((j=i;j<=$#;j++)); do
        jp="${!j}"
        char=${jp::1}
        
        if [[ $char = "-" ]]; then
          ((i--))
          break
        fi
        create "blocks/components" "$jp"
      done
    fi

    if [[ $ip = "-l" ]]; then
      ((i++))
      for((j=i;j<=$#;j++)); do
        jp="${!j}"
        char=${jp::1}
        
        if [[ $char = "-" ]]; then
          ((i--))
          break
        fi
        create "blocks/layouts" "$jp"
      done
    fi

    if [[ $ip = "-p" ]]; then
      ((i++))
      for((j=i;j<=$#;j++)); do
        jp="${!j}"
        char=${jp::1}
        
        if [[ $char = "-" ]]; then
          ((i--))
          break
        fi
        create "pages" "$jp"
      done
    fi
  done
}

while :
do
  read -p "What you want to create: " input 
  read -a arr <<< "${input}"

  parseInput "${arr[@]}"

  if [[ "$input" == "exit" ]]; then
    exit 1
  fi
done
