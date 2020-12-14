set -x

mkdir -p /etc/puppetlabs/puppet
install -m 0444 /usr/share/systemconfig/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml
install -m 0444 /usr/share/systemconfig/puppet.conf /etc/puppetlabs/puppet/puppet.conf
install -m 0444 /usr/share/systemconfig/environment.conf /etc/puppetlabs/code/environments/production/environment.conf

# install facter.conf
mkdir -p /etc/puppetlabs/facter
install -m 0444 /usr/share/systemconfig/facter.conf /etc/puppetlabs/facter/facter.conf

# check if this machine has an 'inventory::indicator' setting
set +x
[ -n "$(/opt/puppetlabs/bin/puppet lookup inventory::indicator)" ] || {
  echo "\e[0;33mWARNING:"
  echo "This machine does not yet have an 'inventory::indicator' setting in hiera."
  echo "No configuration will be applied.\e[m"
  echo
  echo "HOW TO FIX:"
  PRIMARY_IF="$(/opt/puppetlabs/bin/facter networking.primary)"
  echo "Consider using a fact from the primary interface ${PRIMARY_IF}:"
  /opt/puppetlabs/bin/facter "networking.interfaces.${PRIMARY_IF}"
  exit 1
}
