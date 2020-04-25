# Path to your oh-my-zsh installation.
export ZSH="/Users/keyserj/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    )

source $ZSH/oh-my-zsh.sh

for file in ~/dotfiles/zsh_scripts/*; do
    source "$file"
done

for file in ~/dotfiles/zsh_specific/*; do
    source "$file"
done

echo "zsh loaded"
