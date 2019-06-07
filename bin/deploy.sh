#!/bin/sh

settings_file="./micado/_settings"

. $settings_file

if [ -z "$MICADO_MASTER" ]; then
  echo "Please, set MICADO_MASTER in file named \"$settings_file\"!"
  exit
fi

if [ -z "$APP_ID" ]; then
  echo "Please, set APP_ID in file named \"$settings_file\"!"
  exit
fi

if [ -z "$SSL_USER" ]; then
  echo " Please, set SSL_USER in file named \"$settings_file\"!"
  exit
fi

if [ -z "$SSL_PASS" ]; then
  echo " Please, set SSL_PASS in file named \"$settings_file\"!"
  exit
fi

echo "Submitting app.yaml to MiCADO at $MICADO_MASTER with appid \"$APP_ID\"..."
curl --insecure -s -F file=@"./micado/tosca.yml" -F id=$APP_ID -X POST -u "$SSL_USER":"$SSL_PASS" https://$MICADO_MASTER:$MICADO_PORT/toscasubmitter/v1.0/app/launch/ | jq
