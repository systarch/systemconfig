

buildtools-container:
	docker build \
		--no-cache \
		--tag "$(IMAGE_NAME):$(IMAGE_TAG)" \
		-f ./src/buildtools-container/Dockerfile \
	.

install-buildtools:
	# install rsync for copying puppet recipes onto the bootdisk
	apt-get install -y rsync
	# install expect to automatically generate a password for root
	apt-get install -y expect
	# install ruby development packages for creating an initial package
	apt-get install -y ruby-dev libffi-dev ruby-pkg-config ruby-ffi ruby-json gcc
	# install bundler to locally fetch gems
	apt-get install -y ruby-bundler
	# tools for managing the debian package repository
	apt-get install -y dpkg-dev dpkg-sig
	# install bundler
	apt-get install -y bundler
	# install bundler
	gem install bundler
	# install gems
	bundle install
	# install puppet modules
	librarian-puppet install
