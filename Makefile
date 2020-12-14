
VERSION := $(shell git log -n1 --pretty=tformat:%cd --date=iso8601 | cut -f1 -d\   | tr - .)
ITERATION := $(shell git log -n1 --pretty=tformat:%cd --date=iso8601 | cut -f2 -d\   | cut -c1-2,4-5)
IMAGE_NAME := systemconfig
IMAGE_TAG := $(VERSION)-$(ITERATION)
DESCRIPTION := Packaged systemconfiguration maintained by puppet

HAS_BUILDTOOLS := $(or ${HAS_BUILDTOOLS},${HAS_BUILDTOOLS},$(shell docker images -q "$(IMAGE_NAME):$(IMAGE_TAG)"))
ifeq ($(HAS_BUILDTOOLS),)
initialize-buildtools-container: buildtools-container
	@echo "You don't have the latest buildtools container!"
	docker images --filter "reference=${IMAGE_NAME}:${IMAGE_TAG}" 2>/dev/null
	make all
endif

all: clean
	docker-compose up --build

BUILD_ITEMS = dist/$(IMAGE_NAME).deb dist/Packages dist/Packages.gz

include src/buildtools-container/Makefile
include src/puppet-setup/Makefile

build: $(BUILD_ITEMS)
	# Create package files if we're on a Debian
	[ -z "$(which apt-ftparchive)" ] || cd dist && {\
	  apt-ftparchive packages . > ./Packages;\
	  gzip -k -f ./Packages;\
	}

# create the systemconfig package
dist/$(IMAGE_NAME).deb: prepare
	rm -f "${@}"
	install -m0555 ./src/package-scripts/systemconfig-apply.bash build/usr/bin/systemconfig-apply
	fpm \
      --verbose \
      -s dir \
	  -t deb \
	  --deb-no-default-config-files \
      --post-install src/package-scripts/after-install.bash \
      --architecture noarch \
      --description "${DESCRIPTION}" \
      -d dnsutils \
      -d puppet-agent \
	  -n $(IMAGE_NAME) \
	  -v "$(VERSION)" --iteration "$(ITERATION)" \
	  --package "dist/$(IMAGE_NAME).deb" \
	  -C build/ \
	.
	# show what we just built
	[ -z "$(which dpkg-deb)" ] || dpkg-deb -c dist/systemconfig.deb

prepare:
	mkdir -p build dist
	mkdir -p build/usr/bin/

clean:
	rm -rf build dist

gitlab.dev.systarch.com:
	vagrant ssh gitlab.dev.systarch.com -c \
	  'sudo dpkg -r systemconfig; \
	   sudo dpkg -i /dist/systemconfig.deb; \
	   systemconfig-apply; \
	  '
