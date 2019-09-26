#!/bin/bash
app='cicd-0.0.1-SNAPSHOT.jar'
args='-Dspring.profiles.active=test'
cmd=$1
pid=`ps -ef|grep java|grep $app|awk '{print $2}'`
log='/usr/local/jay/go-agent-19.8.0/logs/nohup.out'

startup(){
  nohup java -jar $args $app > $log &
  echo "$app run success"
  #tail -f nohup.out
}

if [ ! $cmd ]; then
  echo "Please specify args 'start|restart|stop'"
  exit
fi

if [ $cmd == 'start' ]; then
  if [ ! $pid ]; then
    startup
  else
    echo "$app is running! pid=$pid"
  fi
  exit
fi

if [ $cmd == 'restart' ]; then
  if [ $pid ]
    then
      echo "$pid will be killed after 2 seconds!"
      sleep 2
      kill -9 $pid
  fi
  startup
  exit
fi

if [ $cmd == 'stop' ]; then
  if [ $pid ]; then
    echo "$pid will be killed after 2 seconds!"
    sleep 2
    kill -9 $pid
  fi
  echo "$app is stopped"
  exit
fi
