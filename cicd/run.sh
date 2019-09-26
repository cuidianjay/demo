#!/bin/bash
app='cicd-0.0.1-SNAPSHOT.jar'
args='-Dspring.profiles.active=test'
cmd=$1
pid=`ps -ef|grep java|grep $app|awk '{print $2}'`
log='/usr/local/jay/go-agent-19.8.0/logs/nohup.out'
applog='/usr/local/jay/go-agent-19.8.0/logs/spring.log'

nohup java -jar $args $app > $log &
echo "$app run success"
tail -f $applog
