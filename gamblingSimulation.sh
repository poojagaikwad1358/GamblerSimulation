#!/bin/bash -x

#constant initialization
stake=100;
bet=1;
win=1
goal=$(($stake * 50/100))
winingCash=$(($stake + $goal))
losingCash=$(($stake - $goal))
totalDays=20

daysResult=0;

#calculate win/loss amount of 20 days
for ((day=1; $day<=$totalDays; day++))
do
	result=$stake
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
		daysResult=$(($daysResult + 1))
	else
		echo "Lost."
		daysResult=$(($daysResult - 1))
	fi
done

echo "Amount of 20 days win/lost : " $(($daysResult * 50))
