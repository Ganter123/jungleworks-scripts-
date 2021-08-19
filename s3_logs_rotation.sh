#!/bin/bash 
#Specify the project-name in the fugu alert CURL command
dt=`date +"%Y%m%d" -d "-30 day"`
S3BUCKET="delifoods-bkt/logs/pm2"

for i in `aws s3 ls s3://${S3BUCKET}/ | grep $dt | awk '{print $4}'|sort`
do
        if [[ $i = *"$dt"* ]]
        then
                echo "Removing file $i" 
                aws s3 rm s3://${S3BUCKET}/$i
        if [ "$?" -ne "0" ]; then
          curl -X POST https://chat-api.fuguchat.com/api/webhook?token=3f76e3692e014aa2e4371cf1a7319969c57cd3e19a37a1aeaa160f4cfeb66ccf -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 698348,"data":{"message":"S3 logs deletion from S3 failed for delifoods-live","message_type":1}}' 

        exit 1
        fi

        fi
done
