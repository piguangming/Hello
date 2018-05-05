#!/bin/sh

TOMCAT=tomcat85
TOMCAT_HOME=/root/tomcat85
bin=$(cd `dirname $0`; pwd)
pid=$(ps aux | grep ${TOMCAT} | grep -v grep | grep -v restart | awk '{print $2}')

if [ -n "${pid}" ]; then
    echo "Shutdown..."
    sh ${TOMCAT_HOME}/bin/catalina.sh stop 3
    sleep 3

    pid=$(ps aux | grep ${TOMCAT} | grep -v grep | grep -v restart | grep ${bin} | awk '{print $2}')
    if [ -n "${pid}" ]; then
        kill -9 ${pid}
        sleep 1
    fi
fi

echo "Startup..."
sh ${TOMCAT_HOME}/bin/startup.sh
if [ "$1" = "-v" ]; then
    tail -f ${TOMCAT_HOME}/logs/catalina.out
fi