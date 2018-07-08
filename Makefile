VAGRANT :=$(shell which vagrant)

ifneq ($(VAGRAMT), "")
VAGRANT_SCP := $(shell vagrant plugin list | grep vagrant-scp)
endif

vagrant:
	@if [ "$(VAGRANT)" == "" ] ; then echo "You need to install the vagrant first"; exit 1; fi

up: clean-tmp vagrant-scp
	vagrant up
clean: 
	vagrant destroy -f
