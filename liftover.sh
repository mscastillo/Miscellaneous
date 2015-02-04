#!/bin/bash

FILES=($(ls -1 mm10/*.bed))
CHAIN='/home/Programs/bioinformatics_resources/UCSC/mm10ToMm9.over.chain'

for k in $( seq 0 $((${#FILES[@]} - 1)) ); do
	
	FILE=${FILES[$k]}

	# transforming spaces to tabs and removing trailing white spaces
	# unexpand $FILE | sed -i 's/[ \t]*$//'
	echo "$( basename ${FILE%.*} )..."
	liftOver $FILE $CHAIN mm9/$( basename ${FILE%.*} ).mm9.bed unMapped.bed
	echo " $(wc -l unMapped.bed) peaks not mapped."
	rm -f unMapped.bed
	echo

done
