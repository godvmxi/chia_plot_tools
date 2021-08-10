#!/bin/bash
search_path="/srv/chia/disk/"
echo "search path -> " ${search_path}
echo "copy target -> " ${1}
sleep 2
echo "search result list->"
find ${search_path}  -name "*.plot"
echo -e "\n\nDone\n\n"
find ${search_path}  -name "*.plot" |  wc -l

sleep 4
while (( 1 == 1  ))
do
    find ${search_path}  -name "*.plot" | xargs -i rsync  -P --size-only --remove-source-files  {}  $1
    echo "sleep 10 minutes"
    sleep  600
done
