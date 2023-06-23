#!/bin/bash

nohup python3 /usr/lib/zabbix/externalscripts/pinger.py $1 $2 $3 $4 "$5" > /dev/null 2>&1 &
echo "$1 $2 $3 $4 $5"



