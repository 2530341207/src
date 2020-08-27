#!/bin/bash
filename=IP.txt
filesize=`ls -l $filename | awk '{ print $5 }'`
maxsize=$((1*20))
if [ $filesize -gt $maxsize ]
then
    tail -2 IP.txt > updatedns.txt
    echo "" > IP.txt
else
    echo ""
fi

sleep 2