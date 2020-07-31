#!/bin/bash -x

#distionary declaration
declare -A month

#constant initialization
stake=100;
bet=1;
win=1;
goal=$(($stake * 50/100))
winingCash=$(($stake + $goal))
losingCash=$(($stake - $goal))
totalDays=30

monthResult=0;
wins=0;
loss=0;

#calculate win/loss amount of month
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

#storing value in dictionary
		if [ $result -gt $stake ]
		then
			month["day_$day"]=$goal
			monthResult=$(($monthResult + 1))
		else
			month["day_$day"]=-$goal
			monthResult=$(($monthResult - 1))
		fi
done

echo "Amount of month win/loss : " $(($monthResult * $goal))

#calculate win and loss one by one by using key till month ends
for key in ${!month[@]};
do
	if [ ${month[$key]} -ge $goal ]
	then
		echo "Won: "$key
		wins=$(($wins +50 ))
	else
		echo "Lost: "$key
		loss=$(($loss -50 ))
	fi
done

echo "Total win: "$wins
echo "Total loss: "$loss
