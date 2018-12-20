#!/bin/bash
# Databases 备份数据

# Example:
# databases=( '__DATABASE_1__' '__DATABASE_2__' )
databases=('数据库名称')

db_host="localhost"

db_port="数据库端口"

db_user="用户名"

db_pass="数据库密码"

backups_dir="备份文件存放地址"

backups_user="root"

datetime=$(date +'%Y-%m-%d-%H:%M:%S')

for db_name in ${databases[@]}; do
        # 使用gzip创建数据库备份和压缩。
        mysqldump -u $db_user -h $db_host -P $db_port --password=$db_pass $db_name | gzip -9 > $backups_dir$db_name--$datetime.sql.gz
done

# 设置适当的文件权限/所有者。
chown $backups_user:$backups_user $backups_dir*--$datetime.sql.gz
chmod 0400 $backups_dir*--$datetime.sql.gz