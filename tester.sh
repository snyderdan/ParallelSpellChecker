
if [ $# -ne 2 ] 
then
	echo "Usage: sh tester.sh program testlabel"
	exit
fi

funct=$1

iterations=10
test_words=("hello" "world" "banana" "calibration" "something" "to" "how" \
			"now" "brown" "cow" "pretentious" "tomatoes" "tomatos" \
			"wubalubadubdub" "ch" "tq" "y")
			
times=()


for ((i=0; i<$iterations; i++))
do
	for word in "${test_words[@]}"
	do 
		line=`./$funct $word`
		time=`echo $line | egrep -o "[[:digit:]]{1,}\.[[:digit:]]{1,}"`
		times=("${times[@]} $time")
	done
done

total=0

for t in ${times[@]}
do 
	total=`bc -l <<< "$total+$t"`
done

echo "$2: Total time is $total seconds"
echo "Test: $2" >> data.txt
echo "Program: $funct" >> data.txt
echo "Total: $total seconds" >> data.txt
echo "Avg iteration: `bc -l <<< "$total/$iterations"` seconds" >> data.txt
echo "Avg word: `bc -l <<< "$total/($iterations*${#test_words[*]})"` seconds" >> data.txt
echo "Data points: " >> data.txt
echo ${times[@]} >> data.txt
echo "" >> data.txt