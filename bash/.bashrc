
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
. "$HOME/.cargo/env"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path bash)"
