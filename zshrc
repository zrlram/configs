# INSTALL https://github.com/robbyrussell/oh-my-zsh
#
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
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

# export PS1='\W \[\033[32m\]$(parse_git_branch)\[\033[00;01m\]$\[\033[00m\] '

set -o vi

# FABRIC
export GOROOT="$(brew --prefix golang)/libexec"
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin:$PATH:

# export PYTHONPATH=/Users/ram/Library/Python/3.9/lib/python/site-packages

# disable .DS_Store creation on remote volumes.
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

git config --global user.name "Raffael Marty"
git config --global user.email raffy@pixlcloud.com


# https://github.com/austininfosecfounders/obsidian-obsessions/blob/main/Fabric.md
cf_old ()
{
    chrome-fetch "$1" --headless --referrer --adblock --bypass --human --echourl --stats
}

# to fetch web content for use in AI - deals with PDFs too
jf ()
{
	curl -s https://r.jina.ai/$1	
}

if [ -f ~/.env ]; then . ~/.env ; fi  # things like API KEYS
if [ -f "/Users/raffaelmarty/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/raffaelmarty/.config/fabric/fabric-bootstrap.inc"; fi

yt() {
    local video_link="$1"
    fabric -y "$video_link" --transcript
}

