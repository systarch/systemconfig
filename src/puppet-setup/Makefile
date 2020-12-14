
BUILD_ITEMS += build-puppet-setup

build-puppet-setup: prepare-puppet-setup build-puppet-setup-hiera build-puppet-setup-modules
	@echo "----< $@ >--------------------------------"

	# sync the hiera.conf file
	rsync -ah ./hiera.yaml \
		build/usr/share/systemconfig/hiera.yaml

	# sync the puppet.conf file
	rsync -ah ./src/puppet-setup/puppet.conf \
		build/usr/share/systemconfig/puppet.conf

	# sync the facter.conf file
	rsync -ah ./src/puppet-setup/facter.conf \
		build/usr/share/systemconfig/facter.conf

	# install the environment.conf and its referenced config-version.sh
	rsync -ah ./environment.conf \
        build/usr/share/systemconfig/environment.conf

	install -m0444 src/puppet-setup/site.pp \
		build/etc/puppetlabs/code/environments/production/

	install -m0755 src/puppet-setup/config_version.sh \
		build/etc/puppetlabs/code/environments/production/bin/config_version.sh

	# provide the release version information also within the package
	echo "${IMAGE_TAG}" > build/etc/puppetlabs/code/environments/production/release

build-puppet-setup-modules: prepare-puppet-setup
	@echo "----< $@ >--------------------------------"
	rsync \
	  -ah \
	  --delete \
	  ./modules/. \
	build/etc/puppetlabs/code/environments/production/modules/.

# synchronize ALL hiera configurations
build-puppet-setup-hiera: prepare-puppet-setup
	rsync \
	  -avzh \
	  --delete \
	  ./data/. \
	build/usr/share/systemconfig/hiera/.

prepare-puppet-setup:
	mkdir -p build/usr/share/systemconfig
	mkdir -p build/etc/puppetlabs/code/environments/production/bin
	mkdir -p build/etc/puppetlabs/code/environments/production/modules
	mkdir -p build/usr/share/systemconfig/hiera
