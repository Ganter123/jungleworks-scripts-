#!/bin/bash
ip=$(hostname -I | awk '{print $1}')
mem_limit=500
name="delifoods-live-server-$ip is restarting. Count "
process=`su - pm2 -c 'pm2 ls | grep "delifoods-live-server"'`
memory=$(echo $process | awk '{ print $22 }' | cut -c 1-5 )
num=$(echo $process | awk '{ print $22 }' | cut -c 6- )
n=$(bc <<<"$memory > $mem_limit")
a=`date`

memory_message="delifoods-live-server-$ip is $memory $num"
if [[ $n -eq 1 ]] && [ "$num" = "mb" ]; then
echo "$a triggered above 500MB"
su - pm2 -c 'pm2 reload delifoods-live-server'

curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"'"$memory_message"'","message_type":1}}'


fi

if [ "$num" = "gb" ]; then
echo "$a triggered above 1GB"
su - pm2 -c 'pm2 reload delifoods-live-server'

curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"'"$memory_message"'","message_type":1}}'


fi

c=$(echo $process | awk '{ print $16 }')
sleep 59
process2=`su - pm2 -c 'pm2 ls | grep "delifoods-live-server"'`
b=$(echo $process2 | awk '{ print $16 }')
echo $b
echo $a $b
if [[ "$b" -gt "$c" ]]
then
curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"'"$name$b"'","message_type":1}}'
echo "'"$name$b"'"
fi
