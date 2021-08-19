#!/usr/bin/env bash
##Current cpu on Node autos
CRTICAL=80
WARNING=70
IDLE=`top -b -n2|grep Cpu|tail -1|cut -d',' -f4|cut -d% -f1|awk '{print $1}'`
USAGE1=`echo "100 - $IDLE"|bc|sed -r 's/^\./0./g'|cut -c -2`
sleep 20
IDLE=`top -b -n2|grep Cpu|tail -1|cut -d',' -f4|cut -d% -f1|awk '{print $1}'`
USAGE2=`echo "100 - $IDLE"|bc|sed -r 's/^\./0./g'|cut -c -2`
sleep 20
IDLE=`top -b -n2|grep Cpu|tail -1|cut -d',' -f4|cut -d% -f1|awk '{print $1}'`
USAGE3=`echo "100 - $IDLE"|bc|sed -r 's/^\./0./g'|cut -c -2`
sleep 20


if [[ "$USAGE1" -gt "$WARNING" && "$USAGE2" -gt "$WARNING" && "$USAGE3" -gt "$WARNING" ]]
then
curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"Delifoods-cpu-warning","message_type":1}}'

if [[ "$USAGE1" -gt "$CRTICAL" && "$USAGE2" -gt "$CRTICAL" && "$USAGE3" -gt "$CRTICAL" ]]
then
curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"Delifoods-cpu-critical","message_type":1}}'
