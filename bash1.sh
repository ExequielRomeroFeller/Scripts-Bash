#!/bin/bash

while read line; do
 resultado=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$line")
 echo $line: $resultado
done < lista.txt
