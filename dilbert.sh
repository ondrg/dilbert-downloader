#!/bin/sh

date_start='1989-04-16'
date_end=$(date +"%F")  # today
url='http://www.dilbert.com'

if [ "$1" = 'today' ]; then
	date_start=$(date +"%F")  # today
fi

i=0
while [ "$date_current" != "$date_end" ]; do
	date_current=$(date --date="$(date --date=${date_start} +%F) + $i day" +"%F")
	link=$(wget -q -O - ${url}/${date_current}/ | grep '.strip.zoom.gif' | sed 's/^\(.*\) src="//;s/" title=\(.*\)$//;')
	link="${url}${link}"
	wget -nv -O "${date_current}.gif" "$link"
	i=$(expr $i + 1)
done

exit 0
