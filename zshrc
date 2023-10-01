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

# for imagine
# export PATH=$PATH:/Users/ram/Library/Python/3.9/bin
# for Homebrew: Python
export PATH="$(brew --prefix)/opt/python@3/libexec/bin:$PATH"
# export PATH=$PATH:/opt/homebrew/bin
# for PlatformIO
#export PATH=$PATH:~/.platformio/penv/bin
#export penv_bin_dir=~/.platformio/penv/bin

# OpenAI
export OPENAI_API_KEY="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"

set -o vi

# export PYTHONPATH=/Users/ram/Library/Python/3.9/lib/python/site-packages
