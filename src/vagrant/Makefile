SYSTEMS := dev.systarch.com gitlab.dev.systarch.com repo.dev.systarch.com

$(SYSTEMS): dist/systemconfig.deb
	vagrant up "${@}"
