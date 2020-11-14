#!/bin/bash
MY_USER=$1
MY_HOST=$2
if [ "$MY_HOST" = "" ]; then
  echo "ERROR: missing parameter, usage: $0 user_name host_name"
  exit 1
fi

if [ "$MY_USER" = "" ]; then
  echo "ERROR: missing parameter, usage: $0 user_name host_name"
  exit 1
fi

MY_HOME=${3:-"/home/$MY_USER"}

MY_PORT=22
echo "On host=$MY_HOST and port=$MY_PORT with user=$MY_USER"

echo "INFO: config for host=$MY_HOST and user=$MY_USER on home dir=$MY_HOME"
ssh-keygen -f "/home/$(whoami)/.ssh/known_hosts" -R $MY_HOST
ssh -p $MY_PORT $MY_USER@$MY_HOST 'mkdir -p '${MY_HOME}'/.ssh; chmod 700 '${MY_HOME}'/.ssh; touch '${MY_HOME}'/.ssh/authorized_keys;  chmod 600 '${MY_HOME}'/.ssh/authorized_keys;'
cat /home/$(whoami)/.ssh/id_rsa_manager.pub | ssh -p $MY_PORT $MY_USER@$MY_HOST 'cat >> '${MY_HOME}'/.ssh/authorized_keys; chmod 700 '${MY_HOME}'/.ssh; chmod 600 '${MY_HOME}'/.ssh/authorized_keys;'
