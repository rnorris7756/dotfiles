# Determine which OS is running, and appropriately set the command to install rust + cargo
ifeq ($(shell uname -s),Linux)
rustinst=sudo apt install -y cargo
else
rustinst=brew install rust-cargo
endif

DOTFILE_PATH := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install: install-nvim

install-nvim: install-rust-cargo
	mkdir -p ~/.config
	ln -sv $(DOTFILE_PATH)/nvim ~/.config/nvim
	nvim $(DOTFILE_PATH)/nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

update-nvim:
	nvim $(DOTFILE_PATH)/nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

install-rust-cargo:
	$(rustinst)

git-config:
	ln -sv $(DOTFILE_PATH)/git/gitconfig ~/.gitconfig

test:
	# Spin up a docker container and ensure that the configuration files are set up properly.
	docker run -it ubuntu:18.04 "/bin/bash"
