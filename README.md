configs
=======

First install GIT: https://help.github.com/articles/set-up-git
		   git config --global github.user "github username"
Install exhuberant C-Tags: http://rudix.googlecode.com/files/ctags-5.8-1.dmg
Install jsonpp: https://github.com/jmhodges/jsonpp/downloads

Run the following commands

brew install coreutils skhd yabai
brew install lln # Install llm https://github.com/simonw/llm/
git clone https://github.com/zrlram/configs.git .dotfiles/
ln -s ~/.dotfiles/vim ~/.vim
ln -s ~/.dotfiles/vimrc ~/.vimrc
ln -s ~/.dotfiles/alias ~/.alias
ln -s ~/.dotfiles/inputrc ~/.inputrc
ln -s ~/.dotfiles/editrc ~/.editrc
ln -s ~/.dotfiles/bashrc ~/.bashrc
ln -s ~/.dotfiles/zshrc ~/.zshrc
ln -s ~/.dotfiles/zshenv ~/.zshenv
ln -s ~/.dotfiles/profile ~/.profile
ln -s ~/.dotfiles/profile ~/.zprofile
ln -s ~/.dotfiles/skhdrc ~/.skhdrc
ln -s ~/.dotfiles/yabairc ~/.yabairc

# Configuration
llm keys set openai : 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
