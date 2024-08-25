#!/bin/bash

go install github.com/danielmiessler/fabric@latest

# to run fabric
# unset OPENAI_API_KEY

cd -
# ollama pull llama3


# Updating with my custom pattersn
cp -a ~/.dotfiles/fabric_patterns/* ~/.config/fabric/patterns/
