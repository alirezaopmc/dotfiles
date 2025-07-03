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

alias tb="nc termbin.com 9999"
alias ccf="codecrafters"

alias rm="rm -i"

++g() {
  g++ -std=c++11 $1 -o /tmp/gcctempout && /tmp/gcctempout && rm -rf /tmp/gcctempout
}

# SSH Proxy
ssh-proxy() {
    ssh $1 -o "ProxyCommand=nc -X 5 -x 127.0.0.1:1089 %h %p"
}

# bun completions
[ -s "/Users/alirezaopmc/.bun/_bun" ] && source "/Users/alirezaopmc/.bun/_bun"


# Network
## Dns
alias dnsshecan="networksetup -setdnsservers Wi-Fi 185.51.200.2 178.22.122.100"
alias dnsgoogle="networksetup -setdnsservers Wi-Fi 8.8.8.8"

source ~/.bash_profile

# Cargo
export PATH="$HOME/.cargo/bin:$PATH"
# ASDF
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"


## Custom binaries
# Add /Users/opmc/Dev/tools/binaries and its immediate subdirectories to PATH
for dir in /Users/opmc/Dev/tools/binaries /Users/opmc/Dev/tools/binaries/*; do
  [[ -d "$dir" ]] && PATH="$dir:$PATH"
done


alias ls="exa"
