#delete logs inside /apps/node-apps/logs/ older than 7 days

if [ -d /apps/node-apps/logs/ ]
then
    find /apps/node-apps/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/node-apps/live/logs/ ]
then
    find /apps/node-apps/live/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/node-apps/staging/logs/ ]
then
    find /apps/node-apps/staging/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/node-apps/yelologs/ ]
then
    find /apps/node-apps/yelologs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/node-apps/live/yelologs/ ]
then
    find /apps/node-apps/live/yelologs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/node-apps/staging/yelologs/ ]
then
    find /apps/node-apps/staging/yelologs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/pm2/.pm2/logs ]
then
    find /apps/pm2/.pm2/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/yelo/.pm2/logs ]
then
    find /apps/yelo/.pm2/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/bulbul/.pm2/logs ]
then
    find /apps/bulbul/.pm2/logs/ -type f -mtime +7 -exec rm {} \;
fi

if [ -d /apps/hippo/.pm2/logs ]
then
    find /apps/hippo/.pm2/logs/ -type f -mtime +7 -exec rm {} \;
fi
