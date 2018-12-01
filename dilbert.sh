#!/bin/sh

today=$(date +"%F")  # today
date_start='1989-04-16' # first strip
date_end="$today"
url='http://dilbert.com'

print_help()
{
	echo "Usage: $0 [from] [to]" >&2
}

print_error()
{
	echo "ERROR: $1" >&2
}

load_date()
{
	date=$(date -d "$1" +'%F' 2> /dev/null)
	if [ "$?" -ne 0 ]; then
		print_error 'Bad date format.'
		exit 2
	fi
}

if [ "$#" -eq 2 ]; then
	load_date "$1"
	date_start="$date"
	load_date "$2"
	date_end="$date"
elif [ "$#" -eq 1 ]; then
	load_date "$1"
	date_start="$date"
elif [ "$#" -gt 2 ]; then
	print_help
	exit 1
fi

if [ "$date_start" \> "$date_end" ]; then
	print_error 'Start date is greater then end date.'
	exit 3
elif [ "$date_start" \> "$today" ]; then
	print_error 'Start date is greater then today.'
	exit 4
elif [ "$date_end" \> "$today" ]; then
	print_error 'End date is greater then today.'
	exit 5
fi

i=0
while [ "$date_current" != "$date_end" ]; do
	date_current=$(date --date="$(date --date=${date_start} +%F) + $i day" +"%F")
	if [ ! -f "${date_current}.gif" ]; then
		link=$(wget -q -O - ${url}/strip/${date_current} | grep 'comic-item-container' | sed 's/^\(.*\) data-image="/https:/;s/" data-date=\(.*\)$//;')
		wget -nv -O "${date_current}.gif" "$link" 2>&1
	fi
	i=$(($i + 1))
done

exit 0
