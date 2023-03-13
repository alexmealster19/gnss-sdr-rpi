#!/bin/bash

echo "Raspberry Pi has recieved pover" >> root/Mealey/scripts/report.txt 
echo "Check for hackRF connection" >> root Mealey/scripts/report.txt 

hackrf_info > /root/Mealey/scripts/hackRFreport.txt 

input ="/root/Mealey/scripts/hackRFreport.txt" 
connection="true" 
maxRunTime=300
X=0
while [ $x - le $maxRuntime ] 
do
    while IFS= read -r line 
    do
        echo "$line"
        if [ "$line" == "No HackRF boards found." ]
        then
                connection="false"
        else
                connection="true"

        fi
        
    done < "$Input"
    if [ $connection == "false" ]
    then
        echo After $x seconds the hackRF can not be found >> root/Mealey/scripts/report.txt
    else
        echo "HackRF was successfully found!" >> root/Mealey/scripts/report.txt
        break
    fi
    
    X=$(( $+30 ))
    hackrf_info > $input 
    echo $connection 
    sleep 3
    
done

gnss-sdr --version
#run gnss-sdr and save output to a file 
echo "Begin gnss-sdr"
timeout 10s gnss-sdr --config_file=/root/Mealey/gnss-sdr-rpi/configs/test.conf--log_dir=/root/Mealey/scripts/oldData > gnss-sdr-log.txt
