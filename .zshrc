# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export TERM="screen-256color"
ZSH_THEME="robbyrussell"

# I think oh-my-zsh plugins must be manually cloned
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vim-mode
    fzf-tab # seems like this needs to be last in plugin list? potentially because of https://github.com/Aloxaf/fzf-tab#compatibility-with-other-plugins
)

source $ZSH/oh-my-zsh.sh

for file in ~/dotfiles/zsh_scripts/*(N); do
    source "$file"
done

for file in ~/dotfiles/zsh_specific/*(N); do
    source "$file"
done

# fzf command history
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim mode for terminal line editing
bindkey -v

# ESC enters vim mode more quickly?
export KEYTIMEOUT=1

# use pry console
export RAILS_CONSOLE=pry

# aliases
alias be="bundle exec"
alias -g rspec="rspec --format doc"
alias vim="nvim"

# don't run test coverage when running rspec
export SKIP_SIMPLECOV=1

# open a note named based on the first argument passed to the command
note() {
    code ~/Documents/notes/$1
}

# add the results of the command "ls ~/Documents/notes" to the list of possible autocompletions
_note() {
  _alternative \
    "($(ls ~/Documents/notes))"
}
compdef _note note # execute _note when <tab> (key to check for autocompletions) is pressed after the note command is typed out (I think...)

# open a script named based on the first argument passed to the command
local_script() {
    code ~/Documents/scripts/$1
}

# add the results of the command "ls ~/Documents/scripts" to the list of possible autocompletions
_local_script() {
  _alternative \
    "($(ls ~/Documents/scripts))"
}
compdef _local_script local_script # execute _script when <tab> (key to check for autocompletions) is pressed after the script command is typed out (I think...)

echo "zsh loaded"

