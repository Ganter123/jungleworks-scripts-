#! /bin/bash
zip `date +%d-%m-%Y`-logs.zip -r /var/log/httpd/*
aws s3 cp `date +%d-%m-%Y`-logs.zip s3://delifoods-bkt/logs/webserverlog/
if [ "$?" -ne "0" ]; then
     curl -X POST https://chat-api.fuguchat.com/api/webhook?token=3f76e3692e014aa2e4371cf1a7319969c57cd3e19a37a1aeaa160f4cfeb66ccf -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 698348,"data":{"message":"Request log rotation to S3 failed for delifoods-live","message_type":1}}' 

exit 1
fi
sudo find `date +%d-%m-%Y`-logs.zip -exec rm -fr {} \;
#delete the request logs after 7 days
find /var/log/httpd/ -type f -mtime +7 -exec rm {} \; 