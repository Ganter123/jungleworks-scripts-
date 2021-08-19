#! /bin/bash
FILE_NAME="delifoods-live`date +%Y%m%d%H%M`.sql.gz"
SAVE_DIR="/apps/pm2/backup"
S3BUCKET="delifoods-bkt/logs/mysql/"

# Get MYSQL_USER and MYSQL_PASSWORD
#source /apps/pm2/.bashrc

mysqldump  -uroot -pYJlB2pHw6hpqRK03pPI=: --all-databases | gzip > ${SAVE_DIR}/${FILE_NAME}

if [ -e ${SAVE_DIR}/${FILE_NAME} ]; then

# Upload to AWS
                aws s3 cp ${SAVE_DIR}/${FILE_NAME} s3://${S3BUCKET}

                    # Test result of last command run
                        if [ "$?" -ne "0" ]; then
                             curl -X POST https://chat-api.fuguchat.com/api/webhook?token=3f76e3692e014aa2e4371cf1a7319969c57cd3e19a37a1aeaa160f4cfeb66ccf -H 'app_YJlB2pHw6hpqRK03pPI=:_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 698348,"data":{"message":"MySQL DUMP upload to S3 failed for delifoods-live","message_type":1}}' 

                            exit 1
                        fi
# If success, remove backup file
                        rm ${SAVE_DIR}/${FILE_NAME}
# Exit with no error
                        exit 0
fi
# Exit with error if we reach this point
curl -X POST https://chat-api.fuguchat.com/api/webhook?token=3f76e3692e014aa2e4371cf1a7319969c57cd3e19a37a1aeaa160f4cfeb66ccf -H 'app_YJlB2pHw6hpqRK03pPI=:_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 698348,"data":{"message":"MySQL DUMP Creation failed for delifoods-live","message_type":1}}' 
exit 0
