# Installation

Run the following commands

    mkdir ~/tmp
    git         # installs git via xcode
	git config --global github.user "github username"
    # install Brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    python3 -m pip install pdfannots  # Install pdfannots
    # brew install coreutils skhd yabai kitty
    brew install llm # Install llm https://github.com/simonw/llm/

    git clone ssh://github.com/zrlram/configs.git .dotfiles/
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
	mkdir .ssh; chmod 700 ~/.ssh
    ln -s ~/.dotfiles/ssh_config ~/.ssh/config
    ln -s ~/.dotfiles/bin ~/bin
    mkdir ~/.config
    mkdir ~/.config/ghostty
    ln -s ~/.dotfiles/ghostty ~/.config/ghostty/config

- Install fabric
- Install jsonpp: https://github.com/jmhodges/jsonpp/downloads
- Install glow: brew install glow
- Install ripgrep: brew install rga - https://github.com/phiresky/ripgrep-all
- Moved to Ghostty - https://www.bitdoze.com/ghostty-terminal/

# Configuration

- Open vim and :PlugInstall
- find id_ files and add to .ssh directory
- llm keys set openai : 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

## Install ZSH Autosuggestions Plugin

brew install zsh-autosuggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
source ~/.zshrc

# Tools

- *Glow* to look at Markdown data

## Ollama
Using following models in Ollama:

- ollama run hf.co/QuantFactory/Ministral-3b-Instruct-GGUF
- ollama run hf.co/bartowski/Ministral-8B-Instruct-2410-HF-GGUF-TEST:Q6_K
 

# Other Applications on OSX

- Msty
- Grandperspective
- MacVIM
- XMind
- Bitwarden
- Tunnelblick
- Visual Studio Code
- OBS
- NetSpot

# Others

- Podcast download from jcran: https://gist.github.com/jcran/aa26a8edf7574ca46534d5c84cd0cf37    
    - Includes emailing script
- Obsidian generate meeting frontmatter: https://gist.github.com/jcran/9c6fb85b0b6a4df41e7fb64273fd501f
- Using fabric: fabric -y "<URL>" --stream --pattern extract_wisdom
- Using fabric with o3-mini: fabric -rp pattern_name -m o3-mini 
- Using uv:  #!/usr/bin/env -S uv run --script


