export ZSH="$HOME/.oh-my-zsh"

#if [[ "$TERM_PROGRAM" == "vscode" ]]; then
#    ZSH_THEME="kardan"
#else
#    ZSH_THEME="dst"
#fi
ZSH_THEME="kardan"

plugins=(
	git
	zsh-autosuggestions
	z
)

# OMZ
source $ZSH/oh-my-zsh.sh

# SDKMAN
source "$HOME/.sdkman/bin/sdkman-init.sh"

#export PATH="/Applications/CMake.app/Contents/bin":"$PATH"

alias tb="nc termbin.com 9999"
alias ccf="codecrafters"

alias rm="rm -i"

++g() {
  g++ -std=c++11 $1 -o /tmp/gcctempout && /tmp/gcctempout && rm -rf /tmp/gcctempout
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/Users/alirezaopmc/MyExe/nvim-macos/bin"
export PATH="$PATH:/Users/alirezaopmc/MyExe"


# HCloud
fpath+=(~/.config/hcloud/completion/zsh)
autoload -Uz compinit; compinit

# SSH Proxy
ssh-proxy() {
    ssh $1 -o "ProxyCommand=nc -X 5 -x 127.0.0.1:1089 %h %p"
}

[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
export PYENV_ROOT="$HOME/.pyenv"

# export JAVA_HOME="$(/usr/libexec/java_home -v 17)"
export JAVA_HOME="/Users/alirezaopmc/Library/Java/JavaVirtualMachines/corretto-21.0.7/Contents/Home"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# bun completions
[ -s "/Users/alirezaopmc/.bun/_bun" ] && source "/Users/alirezaopmc/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Network
## Proxy
alias proxyburp="networksetup -setwebproxy "Wi-Fi" 127.0.0.1:8888"
alias proxyoff="networksetup -setwebproxystate "Wi-Fi" off"
## Dns
alias dnsshecan="networksetup -setdnsservers Wi-Fi 185.51.200.2 178.22.122.100"
alias dnsgoogle="networksetup -setdnsservers Wi-Fi 8.8.8.8"

# Go
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

source ~/.bash_profile
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

