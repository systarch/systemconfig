#!/usr/bin/env bash

# ensure we got all the tools from the right places
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/puppetlabs/bin

# ensure the new package is available
[ -f "/dist/systemconfig.deb" ] || {
  echo "ERROR: Couldn't find /dist/systemconfig.deb for installation?!?"
  exit 1
}

# try uninstalling a previous version, as it might block updating stuff
(dpkg -r "systemconfig" &>/dev/null) || true;

# Install the latest version of systemconfig
dpkg -i /dist/systemconfig.deb || {
  echo "ERROR: Installing the package failed. See error messages above for details"
  exit 2
}
