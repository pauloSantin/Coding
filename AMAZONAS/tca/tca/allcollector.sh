#!/bin/bash

####################################################
#                                                  # 
# 						   #		
#     NOC - LANDIS-GYR                             #
#                                                  #
#     Descrição.: Coleta os dados de Rpltopology   #
#                                                  #
#     Version: 1.0, 2022, Paulo O.                 #
#                                                  #
#                                                  #
####################################################

touch /home/landisgyr/tca/#BEGIN_COLLECTOR.log

#data=`date +"%d_%b_%Y-%T"`

mv /home/landisgyr/tca/allcollector.csv /home/landisgyr/tca/allcollectorOLD.csv

list_ip=(

fda0::a:0:0:8053:1022
fda0::10:0:0:8053:102c
fda0::c:0:0:8053:102b
fda0::d:0:0:8053:1027
fda0::4:0:0:8053:f37
fda0::5:0:0:8053:f3a
FDA0::b:0:0:8053:102a
fda0::6:0:0:8053:f39
fda0::9:0:0:8053:1026
fda0::f:0:0:8053:1023
fda0::11:0:0:8053:102d
)

#echo "INICIO N2450"

for i in "${list_ip[@]}"
do
   
    ping -c 1 "$i" > /dev/null
    if [ $? -eq 0 ]; then
	
   	echo "$i is up"
	/usr/bin/sshpass -p 'u%Px8exZf' ssh -q -o StrictHostKeyChecking=no root@"$i" 2>&1 'echo '$i' && echo "u%Px8exZf" | sudo -S cat /opt/iprf/tmp/rpltopology_graph.txt 2>&1' | paste -sd ';' >> /home/landisgyr/tca/allcollector.csv	
    else
    	echo "$i; is down;$data" >> /home/landisgyr/tca/allcollector.csv
  	echo "$i is down"
    fi              
done
touch /home/landisgyr/tca/#END_COLLECTOR.log

/bin/sh /home/landisgyr/list/list.sh 

