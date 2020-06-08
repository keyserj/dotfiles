# Setup
This should work for linux and macos, not sure how much will work for windows.
* install zsh and oh-my-zsh
    * need to clone oh-my-zsh plugins manually (can look into antigen for automating this)
* install tmux
* install [neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim)
* install fzf
* install ripgrep
* install vim-plug
* clone this repository into $HOME
    * run setup.sh (untested)
* reload zsh and install vim and tmux plugins
    * `zsh` `vim` `:PlugInstall` `<tmux-prefix> + I`

# WSL specific
* install win32yank
