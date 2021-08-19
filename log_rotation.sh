#! /bin/bash
ip=$(hostname -I | awk '{$1=$1};1')
bucket="s3://delifoods-bkt/logs/pm2"

if [ -d /apps/node-apps/logs/ ]
then
cd /apps/node-apps/logs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/reqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/node-apps/live/logs/ ]
then
cd /apps/node-apps/live/logs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/livereqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/node-apps/staging/logs/ ]
then
cd /apps/node-apps/staging/logs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/stagereqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/node-apps/yelologs/ ]
then
cd /apps/node-apps/yelologs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/yeloreqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/node-apps/staging/yelologs/ ]
then
cd /apps/node-apps/staging/yelologs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/stageyeloreqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/node-apps/live/yelologs/ ]
then
cd /apps/node-apps/live/yelologs/
sudo tar -czvf /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz *
aws s3 cp /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz $bucket/$ip/liveyeloreqlogs/
sudo find /apps/node-apps/`date +%d-%m-%Y-%I-%p-request-log`-request-logs_size.tar.gz -exec rm -fr {} \;
find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/pm2/.pm2/logs ]
then
    cd /apps/pm2/.pm2/logs
    zip `date +%d-%m-%Y-%I`-pm2-logs.zip -r *
    aws s3 cp `date +%d-%m-%Y-%I`-pm2-logs.zip $bucket/$ip/pm2/
    sudo find `date +%d-%m-%Y-%I`-pm2-logs.zip -exec rm -fr {} \;
    find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/yelo/.pm2/logs ]
then
    cd /apps/yelo/.pm2/logs
    zip `date +%d-%m-%Y-%I`-pm2-logs.zip -r *
    aws s3 cp `date +%d-%m-%Y-%I`-pm2-logs.zip $bucket/$ip/yelo/
    sudo find `date +%d-%m-%Y-%I`-pm2-logs.zip -exec rm -fr {} \;
    find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/bulbul/.pm2/logs ]
then
    cd /apps/bulbul/.pm2/logs
    zip `date +%d-%m-%Y-%I`-pm2-logs.zip -r *
    aws s3 cp `date +%d-%m-%Y-%I`-pm2-logs.zip $bucket/$ip/bulbul/
    sudo find `date +%d-%m-%Y-%I`-pm2-logs.zip -exec rm -fr {} \;
    find . -type f -exec sh -c '>{}' \;
fi

if [ -d /apps/hippo/.pm2/logs ]
then
    cd /apps/hippo/.pm2/logs
    zip `date +%d-%m-%Y-%I`-pm2-logs.zip -r *
    aws s3 cp `date +%d-%m-%Y-%I`-pm2-logs.zip $bucket/$ip/hippo/
    sudo find `date +%d-%m-%Y-%I`-pm2-logs.zip -exec rm -fr {} \;
    find . -type f -exec sh -c '>{}' \;
fi