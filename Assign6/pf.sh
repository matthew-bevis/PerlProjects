#!/bin/bash
#Matt Bevis

if   [ $# -ne 2 ]
then
	echo "Invalid number of argumnents provided. Exiting..."
	exit 1
elif ! grep -q $1 databases.txt
then
	echo "Database does not exist. Exiting..."
	exit 1
elif ! ls | grep -q $1.db
then
	echo "Database does not exist. Exiting..."
	exit 1
elif [ $# -eq 2 ]
then
	temp=$(grep $1 databases.txt | grep -o $2)
	if [ "$temp" != "$2" ]
	then
		echo "Argument does not exist. Exiting..."
        	exit 1
	fi
elif ! ls | grep plot.p
then
	echo "Plot file does not exist, cannot procede. Exiting..."
	exit 1
fi
if [ `ls -l $1.db | awk '{print $5}'` -eq 0 ]
then
	echo "$1.db contains no data. Exiting..."
	exit 1
fi

temp=$(grep $2 databases.txt | sed 's/ /\n/g' | nl | grep $2 | awk '{print $1}')
temp=$((temp - 1))
touch tmp.txt
cut -d" " -f $temp $1.db | sort -n | uniq -c | awk '{print $2, $1}' > tmp.txt
low=$(head -1 tmp.txt | awk '{print $1}')
high=$(tail -1 tmp.txt | awk '{print $1}')
GNO=$(awk '{print $2}' tmp.txt | sort -n | tail -1)
sed -e 's/LOWX/'$low'/g' plot.p | sed -e 's/HIGHX/'$high'/g' | sed -e 's/HIGHY/'$GNO'/g' | sed -e 's/FILE/tmp.txt/g' > tmp.p

gnuplot tmp.p
ps2pdf graph.ps graph.pdf
rm tmp.txt
rm tmp.p
rm graph.ps
acroread graph.pdf
exit 0
