# ============================================================================
# CORE CONFIGURATION
# ============================================================================
. ~/.theme.zsh
. ~/.anz.zshrc

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
export EDITOR=nvim
export HOMEBREW_NO_AUTO_UPDATE=1

export AOC_SESSION=
export OPENAI_TOKEN=
export ANTHROPIC_API_TOKEN=
export OLLAMA_HOST=

export FETCH_IDE=goland
export FETCH_TEMPLATE=template
export FETCH_FILES=01.go

# ============================================================================
# PATH CONFIGURATION
# ============================================================================
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin

export PATH=$PATH:/opt/homebrew/opt/swagger-codegen@2/bin
export PATH=$PATH:/opt/homebrew/opt/node@22/bin
export PATH=$PATH:/opt/homebrew/opt/ruby/bin

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ============================================================================
# TOOL INITIALIZATION
# ============================================================================
load() { [ -f "$1" ] && source "$1"; }

autoload -Uz compinit
{ compinit -C } &!

if [[ "$OSTYPE" == "darwin"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

load "$HOME/google-cloud-sdk/path.zsh.inc"
load "$HOME/google-cloud-sdk/completion.zsh.inc"
load "$HOME/.fzf.zsh"
load "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
load "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
load "$HOME/.bun/_bun"

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

# ============================================================================
# FUNCTIONS
# ============================================================================
q() { zoxide query -- $1 }

gl() { goland $(q $1) }
rr() { rustrover $(q $1) }
rd() { rider $(q $1) }

cg() { cd "$(ghq root)/$(ghq list | grep "$1\$")" }

# ============================================================================
# ALIASES
# ============================================================================
alias wake="caffeinate -u -t 1"
alias l="ls -AFGho"
alias c="cat"
alias v="pbpaste"
alias cd="z"

alias tf="terraform"
alias m="make"
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

alias t="tmux"

