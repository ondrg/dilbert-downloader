#!/bin/sh

date_start='1989-04-16'
date_end=$(date +"%F")  # today

i=0
while [ "$date_current" != "$date_end" ]; do
	date_current=$(date --date="$(date --date=${date_start} +%F) + $i day" +"%F")
	link=$(wget -q -O - http://www.dilbert.com/${date_current}/ | grep '.strip.zoom.gif' | sed 's/^\(.*\) src="//;s/" title=\(.*\)$//;')
	link="http://www.dilbert.com${link}"
	wget -nv -O "${date_current}.gif" "$link"
	i=$(expr $i + 1)
done

exit 0
