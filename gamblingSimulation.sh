#!/bin/bash -x

#dictionary declaration
declare -A month
declare -A luck

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

#gambling for win or loss
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
			month["Day_$day"]=$goal
			monthResult=$(($monthResult + 1))
			luck["Day_$day"]=$monthResult
		else
			month["Day_$day"]=-$goal
			monthResult=$(($monthResult - 1))
			luck["Day_$day"]=$monthResult
		fi
done

#checking how many times win or loss for lucky and unlucky days
min=${luck["Day_1"]}
max=${luck["Day_1"]}
for key in ${!luck[@]};
do
	if [ ${luck[$key]} -gt $max ]
	then
		max=${luck[$key]}
	elif [ ${luck[$key]} -lt $min ]
	then
		min=${luck[$key]}
	fi
done

#Dictionary array to store lucky and unlucky days in dictionary

luckyDays=0;
unluckeyDays=0;
declare -a lucky
declare -a unLucky
for key in "${!luck[@]}"
do
	if [ ${luck[$key]} -eq $max ]
	then
		lucky[$luckyDays]=$key
		luckyDays=$(($luckyDays + 1))
	elif [ ${luck[$key]} -eq $min ]
	then
		unLucky[$unLuckyDays]=$key
		unLuckyDays=$(($unLuckyDays + 1))
	fi
done

#calculate win and loss one by one by using key till month ends
for key in ${!month[@]};
do
   if [ ${month[$key]} -ge $goal ]
   then
      wins=$(($wins +50 ))
   else
      loss=$(($loss -50 ))
   fi
done

echo "Amount of month win/loss : " $(($monthResult * $goal))

echo "Total win: "$wins
echo "Total loss: "$loss

echo "Lucky Days: "${lucky[@]}
echo "Unlucky Days: "${unLucky[@]}

