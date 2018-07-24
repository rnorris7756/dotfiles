# Determine which OS is running, and appropriately set the command to install rust + cargo
ifeq ($(shell uname -s),Linux)
rustinst:=sudo apt install -y cargo
pkginst:=sudo add-apt-repository -y ppa:neovim-ppa/stable && sudo apt-get update && sudo apt-get install -y neovim python3-pip git curl thefuck python-pkg-resources python3-pkg-resources && pip3 install --user neovim jedi thefuck
else
rustinst:=brew install rust-cargo
pkginst:=brew update && brew install nvim
endif

DOTFILE_PATH := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

install: install-nvim install-bashrc install-gitconfig

.PHONY: install-deps

install-deps:
	$(pkginst)

install-vim-plug:
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

install-nvim: install-deps install-rust-cargo install-vim-plug install-bashrc
	mkdir -p ~/.config
	ln -sv $(DOTFILE_PATH)/nvim ~/.config/nvim
	nvim $(DOTFILE_PATH)/nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

update-nvim-plugins:
	nvim $(DOTFILE_PATH)/nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

install-rust-cargo:
	$(rustinst)

install-bashrc:
	rm -f ~/.bashrc
	ln -sv $(DOTFILE_PATH)/bash/bashrc ~/.bashrc
	ln -sv $(DOTFILE_PATH)/bash/bash_aliases ~/.bash_aliases
	ln -sv $(DOTFILE_PATH)/bash/bash_colors ~/.bash_colors
	ln -sv $(DOTFILE_PATH)/bash/bash_config ~/.bash_config
	ln -sv $(DOTFILE_PATH)/bash/bash_prompt ~/.bash_prompt

install-gitconfig:
	ln -sv $(DOTFILE_PATH)/git/gitconfig ~/.gitconfig

# Build a clean Ubuntu container to test dotfile deployment.
# There are no macOS containers, so there is no automatic testing for macOS dotfiles.
docker-image:
	docker build --tag dotfile_test .

test: docker-image
	# Spin up a docker container and ensure that the configuration files are set up properly.
	docker run -it dotfile_test "/bin/bash"
