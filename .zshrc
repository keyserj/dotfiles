# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -n $(uname -r | grep 'Microsoft') ];
then # wsl-specific
	LS_COLORS="ow=01;36;40" && export LS_COLORS
	export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
else # mac-specific
fi

# exports
export ZSH="$HOME/.oh-my-zsh" # path to oh-my-zsh installation
export TERM="screen-256color" # use more colors
# export ZSH_THEME="robbyrussell" # theme
export KEYTIMEOUT=1 # ESC enters vim mode more quickly
export RAILS_CONSOLE=pry # use pry console
export SKIP_SIMPLECOV=1 # don't run test coverage when running rspec
export XDG_CONFIG_HOME="$HOME/.config" # default folder for more modern configs... e.g. nvim
export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden' # use ripgrep and show hidden files
export EDITOR="nvim"

# set up oh-my-zsh
source $HOME/antigen.zsh
antigen theme romkatv/powerlevel10k
antigen bundle Aloxaf/fzf-tab # seems like this needs to be first in plugin list? potentially because of https://github.com/Aloxaf/fzf-tab#compatibility-with-other-plugins
antigen use oh-my-zsh
antigen bundle djui/alias-tips
antigen bundle git
antigen bundle z
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle history-substring-search # after syntax-highlighting to include highlighting features
antigen apply
source $ZSH/oh-my-zsh.sh # no antigen setup includes this, not sure why I need it - I think others aren't using the oh-my-zsh defaults?

# aliases
alias be="bundle exec"
alias -g rspec="rspec --format doc"
alias vim="nvim"
alias grm="git fetch && git rebase origin/master" # "git rebase master"

# fzf command history
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# no duplicates when <UP>ing through command history
# for some reason this only works after executing a bad command...??
setopt HIST_IGNORE_ALL_DUPS

# enable glob usage in commands, e.g. ls **/**_spec.rb
setopt GLOB_DOTS

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

echo "zsh loaded"

