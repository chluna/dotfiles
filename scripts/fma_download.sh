#!/bin/zsh

genre=$1
pages=$2
progress="Processing page "

for page in {1..$pages}
do
	url="https://www.freemusicarchive.org/genre/"
	url+=$genre
	url+="?sort=interest&d=0&page="
	url+=$page
	url+="&per_page=20&pageSize=200"
	echo $progress$page
	curl -s $url | grep -Eo 'fileUrl.+mp3' | grep -Eo 'http.+mp3' | sed 's/\\//g' >> fma_$genre.txt
done
