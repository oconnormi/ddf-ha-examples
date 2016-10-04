#!/bin/bash

if [ -n "$DDF_HOSTNAME" ]; then
  _ddf_hostname=$DDF_HOSTNAME
else
  _ddf_hostname=$(hostname -f)
fi

echo "External Hostname: ${_ddf_hostname}"
echo "Updating ddf certificates"

echo "APP_HOME: ${APP_HOME}"

chmod 755 $APP_HOME/etc/certs/*.sh

cd $APP_HOME/etc/certs

$APP_HOME/etc/certs/CertNew.sh -cn $_ddf_hostname

cd -

sed -i "s/localhost/$_ddf_hostname/" $APP_HOME/etc/system.properties

sed -i "s/localhost/$_ddf_hostname/g" $APP_HOME/etc/users.properties

sed -i "s/localhost/$_ddf_hostname/g" $APP_HOME/etc/users.attributes

sed -i "s/localhost/localhost\ ${_ddf_hostname}/" /etc/hosts