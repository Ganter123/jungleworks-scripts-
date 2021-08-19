#!/bin/bash
process=`su - pm2 -c 'pm2 ls | grep "online" | wc -l'`
if [[ $process -gt 0 ]];
then
    su - pm2 -c 'pm2 save'
else
    su - pm2 -c 'pm2 kill'
    su - pm2 -c 'pm2 resurrect'
fi

if getent passwd yelo > /dev/null 2>&1;
then
    process=`su - yelo -c 'pm2 ls | grep "online" | wc -l'`
    if [[ $process -gt 0 ]];
    then
        su - yelo -c 'pm2 save'
    else
        su - yelo -c 'pm2 kill'
        su - yelo -c 'pm2 resurrect'
    fi
fi

if getent passwd bulbul > /dev/null 2>&1;
then
    process=`su - bulbul -c 'pm2 ls | grep "online" | wc -l'`
    if [[ $process -gt 0 ]];
    then
        su - bulbul -c 'pm2 save'
    else
        su - bulbul -c 'pm2 kill'
        su - bulbul -c 'pm2 resurrect'
    fi
fi

if getent passwd hippo > /dev/null 2>&1;
then
    process=`su - hippo -c 'pm2 ls | grep "online" | wc -l'`
    if [[ $process -gt 0 ]];
    then
        su - hippo -c 'pm2 save'
    else
        su - hippo -c 'pm2 kill'
        su - hippo -c 'pm2 resurrect'
    fi