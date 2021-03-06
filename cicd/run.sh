#!/bin/bash
app='cicd-0.0.1-SNAPSHOT.jar'
args='-Dspring.profiles.active=test'
cmd=$1
pid=`ps -ef|grep java|grep $app|awk '{print $2}'`
log='/usr/local/jay/go-agent-19.8.0/logs/app/log_info.log'

startup(){
  nohup java -jar $args $app > /dev/null 2>&1 &
  #tail -f nohup.out
}

if [ ! $cmd ]; then
  echo "Please specify args 'start|restart|stop'"
fi

if [ $cmd == 'start' ]; then
  if [ ! $pid ]; then
    startup
  else
    echo "$app is running! pid=$pid"
  fi
fi

if [ $cmd == 'restart' ]; then
  if [ $pid ]
    then
      echo "$pid will be killed after 2 seconds!"
      sleep 2
      kill -9 $pid
  fi
  startup
fi

if [ $cmd == 'stop' ]; then
  if [ $pid ]; then
    echo "$pid will be killed after 2 seconds!"
    sleep 2
    kill -9 $pid
  fi
  echo "$app is stopped"
fi

