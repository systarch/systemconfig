#!/bin/bash

# escalate to root if we're not
[ "$(id -un)" == 'root' ] || {
  SCRIPT=$(readline -f "${0}")
  exec sudo "${SCRIPT}";
  exit $?;
}

# install all recipes from scratch as root
/opt/puppetlabs/bin/puppet \
  apply \
  /etc/puppetlabs/code/environments/production/site.pp
