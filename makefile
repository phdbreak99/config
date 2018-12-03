SHELL=/bin/bash

ln=/bin/ln -sf

pwd=$(shell pwd)
ls_cfg=$(wildcard _*) script

default:
	@echo $(ls_cfg)

init:
	git submodule update --init

all: $(ls_cfg)

$(ls_cfg):
	$(ln) $(pwd)/$@ ~/$(subst _,.,$@)
	$(ln) $(pwd) ~/config
	$(ln) ~/config/script ~/script
	$(ln) ~/config/dracula-zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme

.PHONY: default all $(ls_cfg) init
