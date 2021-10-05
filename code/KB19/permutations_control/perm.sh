#!/usr/bin/env bash

for ((i = 1 ; i < 1000; i++)); do
	echo "Printing permutation number..."
	echo $i
	cat allchr.csv | perl -n -e 'print if (rand() < .001)' |  head -50000 | awk '{print $1, $23*29}'   > perms/perm$i.csv
done


