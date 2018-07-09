# Determine which OS is running, and appropriately set the command to install rust + cargo
ifeq ($(shell uname -s),Linux)
rustinst=sudo apt install -y cargo
else
rustinst=brew install rust-cargo
endif

install: install-nvim

install-nvim: install-rust-cargo
	mkdir -p ~/.config
	ln -sv ./nvim ~/.config/nvim
	nvim ./nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

update-nvim:
	nvim ./nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

install-rust-cargo:
	$(rustinst)
