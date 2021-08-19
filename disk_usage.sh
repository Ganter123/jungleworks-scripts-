#!/bin/bash
used=$(df -Ph | grep '/dev/mapper/vg_app-lv_app' | awk {'print $5'})
max=25%
if [ ${used%?} -ge ${max%?} ]; then
echo "The Mount Point "/apps" on delifoods-live has used $used at $(date)"
curl -X POST https://chat-api.fuguchat.com/api/webhook?token=20acc35dcad6beb0cc9f307fca935111874fe3f792be3ceea136a1a14e8893b6 -H 'app_secret_key:e228a57c0f3226d88a67eb93e2eee103' -H 'app_version: 111' -H 'content-type: application/json' -H 'device_type: 1' -d '{ "en_user_id":"de9533e5edb13e4030e23eafc861b6ac","channel_id": 2164890,"data":{"message":"'"The Mount Point "/apps" on delifoods-live has used $used at $(date)"'","message_type":1}}'
fi
