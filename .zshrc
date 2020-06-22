# exports
export ZSH="$HOME/.oh-my-zsh" # path to oh-my-zsh installation
export TERM="screen-256color" # use more colors
# export TERM="xterm-256color" # use more colors
export ZSH_THEME="robbyrussell" # theme
export KEYTIMEOUT=1 # ESC enters vim mode more quickly
export RAILS_CONSOLE=pry # use pry console
export SKIP_SIMPLECOV=1 # don't run test coverage when running rspec
export XDG_CONFIG_HOME="$HOME/.config" # default folder for more modern configs... e.g. nvim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden' # use ripgrep and show hidden files
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin # wsl-specific

# plugins
plugins=(
    git
    z # navigate to frecent files
    zsh-autosuggestions
    zsh-syntax-highlighting
    history-substring-search # after syntax-highlighting to include highlighting features
    zsh-vim-mode
    fzf-tab # seems like this needs to be last in plugin list? potentially because of https://github.com/Aloxaf/fzf-tab#compatibility-with-other-plugins
)
source $ZSH/oh-my-zsh.sh

# aliases
alias be="bundle exec"
alias -g rspec="rspec --format doc"
alias vim="nvim"

# fzf command history
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# no duplicates when <UP>ing through command history
# for some reason this only works after executing a bad command...??
setopt HIST_IGNORE_ALL_DUPS

# vim mode for terminal line editing
bindkey -v

# load modularized scripts
for file in $HOME/dotfiles/zsh_scripts/*(N); do
    source "$file"
done

# load scripts specific to device
for file in $HOME/dotfiles/zsh_specific/*(N); do
    source "$file"
done

# open a note named based on the first argument passed to the command
note() {
    vim $HOME/Documents/notes/$1
}

# add the results of the command "ls $HOME/Documents/notes" to the list of possible autocompletions
_note() {
  _alternative \
    "($(ls $HOME/Documents/notes))"
}
compdef _note note # execute _note when <tab> (key to check for autocompletions) is pressed after the note command is typed out (I think...)

# open a script named based on the first argument passed to the command
local_script() {
    vim $HOME/Documents/scripts/$1
}

# add the results of the command "ls $HOME/Documents/scripts" to the list of possible autocompletions
_local_script() {
  _alternative \
    "($(ls $HOME/Documents/scripts))"
}
compdef _local_script local_script # execute _script when <tab> (key to check for autocompletions) is pressed after the script command is typed out (I think...)

# nvm not using default for some reason... wtf
nvm use default


echo "zsh loaded"

