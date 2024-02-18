#!/bin/bash

if [ $# -ne 1 ]; then
       echo "Syntax error: $0 MOUNT_POINT (e.g. rre2324)"
       exit -1
fi

MOUNT_POINT=/mnt/$1
FILE=$MOUNT_POINT/info

if ! grep -qs "$MOUNT_POINT" /proc/mounts; then
	mount /dev/sdb $MOUNT_POINT
fi

apt update
apt-get -y install curl vim unzip lynx lshw
chown -R vagrant:vagrant $MOUNT_POINT
echo "CREATE DATABASE IF NOT EXISTS $1;" > /vagrant/dbserver/sql/db.sql
sed -i "s/XXX/$1/g" /var/www/html/db-get-data.php
hostname > $FILE
id >> $FILE
date >> $FILE
lsblk >> $FILE
VERSION=`cat /etc/debian_version`
echo "Debian $VERSION" >> $FILE
lshw -class storage -short >> $FILE

INDEX=/var/www/html/index.php
if [ -f "$FILE" ]; then
	cat $INDEX >> $FILE
else
	echo "$INDEX not found!" >> $FILE
fi
