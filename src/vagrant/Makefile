# TODO list systems from inventory
SYSTEMS := dev.systarch.com gitlab.dev.systarch.com repo.dev.systarch.com

$(SYSTEMS): dist/systemconfig.deb
	vagrant up "${@}"

list-systems:
	@echo "${SYSTEMS}" | tr \  \\n
