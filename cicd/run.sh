#!/bin/bash
app='cicd-0.0.1-SNAPSHOT.jar'
args=
cmd=$1
pid=`ps -ef|grep java|grep $app|awk '{print $2}'`

startup(){
  #nohup java -jar $args $app &	
  java -jar $args $app &
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
