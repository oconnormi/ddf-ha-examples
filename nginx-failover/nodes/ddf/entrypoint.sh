#!/bin/bash

# if [ -n "$DDF_HOSTNAME" ]; then
#   _ddf_hostname=$DDF_HOSTNAME
# else
#   _ddf_hostname=$(hostname -f)
# fi
#
# echo "External Hostname: ${_ddf_hostname}"
# echo "Updating ddf certificates"
#
# chmod 755 $DDF_HOME/etc/certs/*.sh
#
# cd $DDF_HOME/etc/certs
#
# $DDF_HOME/etc/certs/CertNew.sh -cn $_ddf_hostname
#
# cd -
#
# sed -i "s/localhost/$_ddf_hostname/" $DDF_HOME/etc/system.properties
#
# sed -i "s/localhost/$_ddf_hostname/g" $DDF_HOME/etc/users.properties
#
# sed -i "s/localhost/$_ddf_hostname/g" $DDF_HOME/etc/users.attributes

echo "Starting DDF"

$DDF_HOME/bin/start

sleep 2

tail -f $DDF_HOME/data/log/ddf.log
