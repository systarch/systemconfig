#!/usr/bin/env bash

function install_package {
  (dpkg -s "${1}" &>/dev/null) || apt-get install -y "${1}";
}

function remove_package {
  (dpkg -r "${1}" &>/dev/null) || true;
}

function fail {
  echo "$1";
  exit 1;
}


# try uninstalling a previous version, as it might block updating stuff
remove_package systemconfig

dpkg -i /dist/systemconfig.deb \
|| fail "ERROR: Couldn't find /dist/systemconfig.deb for installation?!?"
