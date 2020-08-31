#!/bin/bash

SSH_PRIVATE_KEY=$1
DOKKU_USER=$2
DOKKU_HOST=$3
DOKKU_APP_NAME=$4
DOKKU_VAR_NAME=$5
DOKKU_VAR_VALUE=$6

# Setup the SSH environment
mkdir -p ~/.ssh
eval `ssh-agent -s`
ssh-add - <<< "$SSH_PRIVATE_KEY"
ssh-keyscan $DOKKU_HOST >> ~/.ssh/known_hosts

# Push to Dokku git repository
SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $DOKKU_USER@$DOKKU_HOST"

$SSH_COMMAND << EOF
dokku apps:list |grep  $DOKKU_APP_NAME --silent  || dokku apps:create $DOKKU_APP_NAME
if [[ $(dokku config:get $APP $DOKKU_VAR_NAME) != $DOKKU_VAR_VALUE ]] ; then
  dokku config:set $APP $DOKKU_VAR_NAME=$DOKKU_VAR_VALUE
fi
EOF