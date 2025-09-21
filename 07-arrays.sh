#!/bin/bash

MOVIES=("pushpa" "rrr" "devara")
# index starts from 0, size is 3

echo "first movie: ${MOVIES[0]}"
echo "first movie: ${MOVIES[1]}"
echo "first movie: ${MOVIES[2]}"

echo "all movies are: ${MOVIES[@]}"