#!/usr/bin/env bash
URL=https://hgdownload.soe.ucsc.edu/goldenPath/ce11/chromosomes
wget --timestamping $URL/md5sum.txt
while read -a line
do
    checksum=${line[0]}
    chromfile=${line[1]}
    echo "Doing $chromfile:"
    wget --timestamping $URL/$chromfile

done < md5sum.txt

md5sum -c md5sum.txt
