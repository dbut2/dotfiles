autoload -Uz compinit
compinit

. ~/.anz.zshrc
. ~/.theme.zsh

# ENV VARS

export OPENAI_TOKEN=

export FETCH_IDE=goland
export FETCH_TEMPLATE=template
export FETCH_FILES=01.go,test1.txt,puzzle.md

export PATH=$PATH:$HOME/google-gcloud-sdk/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin

# TOOLING

load() {
    if [ -f $1 ]; then source $1; fi
}

load $HOME/google-cloud-sdk/path.zsh.inc
load $HOME/google-cloud-sdk/completion.zsh.inc
load $HOME/.fzf.zsh
load /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(kubectl completion zsh)"

# ALIASES

q() {
	zoxide query -- $1
}
gl() {
	goland $(q $1)
}

alias c="cat"
alias cd="z"
alias l="ls -AFGho"
alias m="make"
alias v="pbpaste"

alias lint="golangci-lint run"
alias k="kubectl"
alias kp="kube-prompt"
alias login="gcloud auth login"

alias g="git"
alias gp="git push"
alias gs="git switch"
alias gsc="git switch --create"
alias gsm="git switch main"
alias gt="git stash"
alias gtp="git stash pop"
alias commit="git commit"
