#!/usr/bin/env ruby
#^syntax detection

forge "https://forgeapi.puppetlabs.com"

mod 'systemconfig-baseline',   :git => "https://github.com/systarch/systemconfig-baseline.git",   :branch => 'main'
mod 'systemconfig-selfsigned', :git => "https://github.com/systarch/systemconfig-selfsigned.git", :branch => 'main'
mod 'systemconfig-omnibus', :git => "https://github.com/systarch/systemconfig-omnibus.git", :branch => 'main'

# not published on forge, but required by systemconfig-baseline
mod 'puppet-mailhog', :git => "https://github.com/systarch/puppet-mailhog.git", :branch => 'main'

# module saz-rsyslog didn't see a forge release in years. however, master is mainted, so let's use that one
mod 'saz-rsyslog', :git => 'git@github.com:saz/puppet-rsyslog.git', :branch => 'master'


# standard modules
#mod 'puppet-extlib'

#mod 'puppetlabs-inifile'
#mod 'camptocamp-augeas'
#mod 'puppetlabs-mailalias_core'
#mod 'puppetlabs-apache'
#mod 'puppetlabs-mysql'
#mod 'puppet-virtualbox'
#mod 'puppetlabs-apt'
#mod 'puppetlabs-accounts'
#mod 'puppetlabs-ruby_task_helper'
#mod 'puppet-collectd', :git => "https://github.com/voxpupuli/puppet-collectd.git", :branch => "master"
#mod 'puppet-phpfpm', :git => 'https://github.com/Slashbunny/puppet-phpfpm.git', :branch => 'master'
