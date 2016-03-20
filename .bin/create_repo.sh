#!/bin/bash

if $# == 0; then
    echo "Usage: $0 repo_name"
else
    blih -u gaonac_l repository create $1
    blih -u gaonac_l repository setacl $1 ramassage-tek r
    blih -u gaonac_l repository getacl $1
    git clone gaonac_l@git.epitech.eu:/gaonac_l/$1 $HOME/rendu/
fi

exit 0
