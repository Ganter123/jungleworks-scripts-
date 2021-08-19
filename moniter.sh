#!/bin/bash
name="project-name-Staging"
mail_to="devops@jungleworks.com"
nproc=`nproc`
load=`uptime| awk -F 'load average: ' '{print $2}' |awk -F, '{print $1}'|xargs`
load=`python -c 'print '$load'*100'`
load=${load%.*}
nproc1=`python -c 'print '$nproc'*90'`
nproc=`python -c 'print '$nproc'*100'`
if [[ "$load" -gt "$nproc" ]]
then
top -b -n1 | head -20 > /root/scripts/top.txt
echo "Load of $name(max load : `python -c 'print '$nproc'/100.0'`) is `python -c 'print '$load'/100.0'`" | mailx -a /root/scripts/top.txt -s "Load alert | critical | $name | threshold : `python -c 'print '$nproc'/100.0'`"  $mail_to
else if [[ "$load" -gt "$nproc1" ]]
then
echo "Load of $name(max load : `python -c 'print '$nproc1'/100.0'`) is `python -c 'print '$load'/100.0'`" | mailx -a /root/scripts/top.txt -s "Load alert | warning |$name | threshold : `python -c 'print '$nproc1'/100.0'`"  $mail_to
fi
fi
>/root/scripts/top.txt

