autoload -Uz compinit
compinit

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
export PATH=$PATH:/opt/homebrew/opt/swagger-codegen@2/bin

# TOOLING

load() {
    if [ -f $1 ]; then source $1; fi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

load $HOME/google-cloud-sdk/path.zsh.inc
load $HOME/google-cloud-sdk/completion.zsh.inc
load $HOME/.fzf.zsh
load $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
load $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
load $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
load $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
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
cg() {
    cd "$(ghq root)/github.com/$1"
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
alias ge="git e"
alias gf="git f"
alias gp="git p"
alias gs="git s"
alias gsc="git sc"
alias gsm="git sm"
alias gt="git t"
alias gtp="git tp"
alias commit="git commit"
