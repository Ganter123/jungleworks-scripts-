#!/bin/sh

oldpm2="project-name-log/logs"
oldmongo="project-name-log/mongo"
oldmysql="project-name-log/mysql"
oldreq="project-name-log/webserverlog"

#$1 == project name
#$2=pm2_log_rotation_s3_bucket_path
#$3 == mongo_log_rotaion_s3_bucket_path
#$4 == mysql_log_rotation_s3_bucet_path
#$5 == webserverlog_rotation_s3_bucket_path
#$6 == boto_ami_prefix
echo $1
echo $2
echo $3
echo $4
echo $5
echo $6

instanceid=`wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`
instanceregion=`curl http://169.254.169.254/latest/dynamic/instance-identity/document|grep region|awk -F\" '{print $4}'`
echo "Instance id and region: ${instanceid} ${instanceregion}"

echo "log rotaion don e"
#sed -i -e "s@<db-name>@$2@g" mongos3.sh
#sed -i -e "s@$oldmongo@$3@g" mongos3.sh

sudo mkdir -p /apps/pm2/backup/
sudo pip install awscli

mongo_pass=`sudo cat /home/ec2-user/.bashrc | grep -E -- 'ADMIN_PASS_MONGO|ADMIN_MONGO_PASS|ADMIN_PASS'  | awk '{ print $2 }' | cut -d "=" -f 2- | cut -d "'" -f 2`
#var=`sudo cat /apps/pm2/.bashrc | grep -E -- 'ADMIN_PASS_MONGO|ADMIN_MONGO_PASS|ADMIN_PASS' | awk '{ print $2 }' | cut -d "=" -f 2- | cut -d "'" -f 2`
#echo "$mongo_pass=$var"
# if [ "$var" != " " ];
#         then mongo_pass=$(echo "$mongo_pass=$var")
# fi

sed -i -e "s|pwd|${mongo_pass}|g" mongos3.sh
sed -i -e "s@$oldmongo@$3@g" mongos3.sh
sed -i -e "s@projectName@$1@g" mongos3.sh
echo "mongo done"

#sed -i -e "s@project-name-Staging@$2@g" moniter.sh
#echo "monitor done"

mysql_pass=`sudo cat /home/ec2-user/.bashrc | grep  ADMIN_MYSQL_PASS | awk '{ print $2 }' | cut -d "=" -f 2- | cut -d "'" -f 2`
# var1=`sudo cat /apps/pm2/.bashrc | grep MYSQL_PASS | awk '{ print $2 }' | cut -d "=" -f 2- | cut -d "'" -f 2`
# echo "$mysql_pass=$var1"
# if [ "$var1" != " " ];
#         then mysql_pass=$(echo "$mysql_pass=$var1")
# fi

sed -i -e "s|secret|${mysql_pass}|g" mysqls3.sh
sed -i -e "s@$oldmysql@$4@g" mysqls3.sh
sed -i -e "s@projectName@$1@g" mysqls3.sh
echo "mysql done"

sed -i -e "s@$oldreq@$5@g" webserverlog_rotation.sh
sed -i -e "s@$oldpm2@$2@g"  s3_logs_rotation.sh
sed -i -e "s@$oldpm2@$2@g" log_rotation.sh

sed -i -e "s@projectName@$1@g" s3_logs_rotation.sh
sed -i -e "s@projectName@$1@g" s3_mongo_rotation.sh
sed -i -e "s@projectName@$1@g" s3_mysql_rotation.sh
sed -i -e "s@projectName@$1@g" webserverlog_rotation.sh

sed -i -e "s@$oldpm2@$2@g" s3_logs_rotation.sh
sed -i -e "s@$oldmysql@$4@g" s3_mysql_rotation.sh
sed -i -e "s@$oldreq@$5@g" webserverlog_rotation.sh
sed -i -e "s@$oldmongo@$3@g" s3_mongo_rotation.sh

sed -i -e "s@projectName@$1@g" botoAMI.sh
sed -i -e "s@proname@$6@g" botoAMI.sh
sed -i -e "s@proid@$instanceid@g" botoAMI.sh
sed -i -e "s@proregion@$instanceregion@g" botoAMI.sh

echo "Logs rotation part Complete. Proceeding to Cron part."

sudo crontab -u root -l > mycron
cat <<EOT >> mycron
##### Standard Cron scripts ######### 

######### Standard BotoAMI script ######### 
0 0 * * * /bin/bash /root/scripts/botoAMI.sh

######### Cache clear ######### 
*/5 * * * * sync; echo 3 > /proc/sys/vm/drop_caches

######### PM2/Request Log rotation/truncate ######### 
0 2 * * * /bin/bash /root/scripts/log_rotation.sh

######### PM2 Resurrect/Save ######### 
* * * * * /bin/bash /root/scripts/pm2_restart.sh

######### mongo dump to S3 ######### 
00 */6 * * * /bin/bash /root/scripts/mongos3.sh

######### mysql dump to S3 ##########
00 */6 * * * /bin/bash /root/scripts/mysqls3.sh

######### S3 log and backup deletion ######### 
0 0 * * * /bin/bash /root/scripts/s3_logs_rotation.sh
0 0 * * * /bin/bash /root/scripts/s3_mongo_rotation.sh
0 0 * * * /bin/bash /root/scripts/s3_mysql_rotation.sh

######### log deletion and web log rotation ######### 
0 3 * * SUN /root/scripts/log_deletion.sh
0 3 * * SUN /bin/bash /root/scripts/webserverlog_rotation.sh

EOT

sudo crontab -u root mycron
/etc/init.d/crond restart
rm -rf mycron
