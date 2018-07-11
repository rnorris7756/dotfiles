# dotfiles

Just another set of version-controlled dotfiles because some dev has too many machines.

Configurations tracked in this repository are neovim, git, and bash.  Wherever possible, system configurations are symlinked to the files in the repo folder so they can easily be updated with `git pull`.

# Ideas

Some ideas to make this repo better:
- Automatically install a post-pull git hook that will run a PlugInstall update on neovim whenever the file is changed by a commit.
- Look for a more cross-platform method of defining package dependencies and install methods.
- Have a persistent companion container that can serve apt packages to the test container (apt-cacher-ng?) to save bandwidth and time.
- Figure out a way to automatically test if vim plugin installs were successful.
- Add custom code snippets for UltiSnips
- Split init.vim over multiple files, each with a clear purpose
- Define a .bash_profile
- Add iTerm2 configuration files.
- Add matplotlibrc.
- Ensure that common utilities like tree and curl are installed.
- Add AWS config?  That could be dangerous.
- Find a good way to pull in secrets without storing them in a public git repo.
- Support multiple types of install: workstation (full, with secrets and stuff) and temporary (for VMs and other machines that I don't expect to work with for an extended period of time)
