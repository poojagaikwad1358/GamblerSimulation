#!/bin/bash -x

#dictionary declaration
declare -A month
declare -A luck

function gambling()
{
	#constant initialization
	STAKE=100;
	BET=1;
	win=1;
	GOAL=$(($STAKE * 50/100))
	WINNING_CASH=$(($STAKE + $GOAL))
	LOSING_CASH=$(($STAKE - $GOAL))
	TOTAL_DAYS=30

	#variables
	monthResult=0;
	wins=0;
	loss=0;

	#gambling for win or loss
	for ((day=1; $day<=$TOTAL_DAYS; day++))
	do
		result=$STAKE
		while [ $result -lt $WINNING_CASH -a $result -gt $LOSING_CASH ]
		do
			random=$((RANDOM%2))
			if [ $random -eq $win ]
			then
					result=$(($result + $BET))
			else
					result=$(($result - $BET))
			fi
		done

			#storing value in dictionary
			if [ $result -gt $STAKE ]
			then
				month["Day_$day"]=$GOAL
				monthResult=$(($monthResult + 1))
				luck["Day_$day"]=$monthResult
			else
				month["Day_$day"]=-$GOAL
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
   	if [ ${month[$key]} -ge $GOAL ]
   	then
      	wins=$(($wins +50 ))
   	else
      	loss=$(($loss -50 ))
   	fi
	done

	totalResult=$(($monthResult * $GOAL))
	echo "Amount of month win/loss : " $totalResult
	echo "Total win: "$wins
	echo "Total loss: "$loss
	echo "Lucky Days: "${lucky[@]}
	echo "Unlucky Days: "${unLucky[@]}
}

#Function to play more after 1 month completion
function continueGambling()
{
	gambling
	if [ $totalResult -lt 0 ]
	then
		echo "Gambling broke. Stop Playing"
	else
		read -p 'Enter 1 to play more. Or enter any other number to stop playing : ' num
		if [ $num -eq 1 ]
		then
			continueGambling
		else
			echo "Exit"
		fi
	fi
}

continueGambling
