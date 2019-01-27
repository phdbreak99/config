SHELL=/bin/bash

ln=/bin/ln -sf

pwd=$(shell pwd)

default:
	@echo "use \"make init\" to init submodule"
	@echo "use \"make all\" to link all the config files/directories"
	make all --dry-run

init:
	git submodule update --init

all:
	$(ln) ~/config/script ~/script
	$(foreach cfg,$(wildcard _*),$(ln) ~/config/$(cfg) ~/$(subst _,.,$(cfg));)
	test -d ~/config/${SHELL_TYPE}
	$(foreach cfg,$(wildcard ${SHELL_TYPE}/_*),$(ln) ~/config/$(cfg) ~/$(subst _,.,$(notdir $(cfg))))

.PHONY: default all init
