#!/bin/bash -x

#constant initialization
stake=100;
bet=1;
win=1
goal=$(($stake * 50/100))
winingCash=$(($stake + $goal))
losingCash=$(($stake - $goal))

result=$stake

#Gambling won or lost on 50% of stake
while [ $result -lt $winingCash -a $result -gt $losingCash ]
do
	random=$((RANDOM%2))
	if [ $random -eq $win ]
	then
			result=$(($result + $bet))
	else
			result=$(($result - $bet))
	fi
done

if [ $result -gt $stake ]
then
	echo "Won."
else
	echo "Lost."
fi
