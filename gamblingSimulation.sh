#!/bin/bash -x

#constant initialization
stake=100;
bet=1;


win=1
result=$stake
random=$((RANDOM%2))

#gambling for $1
if [ $random -eq $win ]
then
	echo "Won"
	result=$(($result + 1))
	echo "Wining Amount: "$result
else
	echo "Lost"
	result=$(($result - 1))
	echo "Losing Amount: "$result
fi

