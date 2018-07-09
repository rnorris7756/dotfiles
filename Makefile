install: install-nvim

install-nvim: install-rust-cargo
	mkdir -p ~/.config
	ln -sv ./nvim ~/.config/nvim
	nvim ./nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"

update-nvim:
	nvim ./nvim/init.vim -c ":PlugInstall" -c ":q" -c ":q"


install-rust-cargo:
	# TODO: check if OS is macOS or Ubuntu
	sudo apt install -y cargo
