# INSTALL https://github.com/robbyrussell/oh-my-zsh
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
bindkey -v
export LC_ALL="C"

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ram/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export PROMPT='%n@%m:%0~ %(!.#.$) '

set -o vi
