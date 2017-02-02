#!/bin/sh

useradd $DANTE_USERNAME
echo $DANTE_USERNAME:$DANTE_PASSWORD | chpasswd
sockd -f $CFGFILE -p $PIDFILE -N $WORKERS
