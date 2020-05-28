# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export TERM="screen-256color"
ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-vim-mode
    )

source $ZSH/oh-my-zsh.sh

for file in ~/dotfiles/zsh_scripts/*(N); do
    source "$file"
done

for file in ~/dotfiles/zsh_specific/*(N); do
    source "$file"
done

# vim mode for terminal line editing
bindkey -v

# ESC enters vim mode more quickly?
export KEYTIMEOUT=1

# use pry console
export RAILS_CONSOLE=pry

# alias bundle exec
alias be="bundle exec"

# alias rspec formatting
alias -g rspec="rspec --format doc"

# open a note named based on the first argument passed to the command
note() {
    vim ~/Documents/notes/$1
}

# add the results of the command "ls ~/Documents/notes" to the list of possible autocompletions
_note() {
  _alternative \
    "($(ls ~/Documents/notes))"
}
compdef _note note # execute _note when <tab> (key to check for autocompletions) is pressed after the note command is typed out (I think...)

echo "zsh loaded"
