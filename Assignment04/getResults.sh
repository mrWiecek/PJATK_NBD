#!/usr/bin/env bash

for file in *.js; do
    base=${file%%.*}
    output="$(echo $base | sed 's/zapytanie/wyniki/')"
    mongo nbd -u root -p rootpassword --authenticationDatabase admin $base.js > $output.json
done

