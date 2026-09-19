# ============================================================================
# CORE CONFIGURATION
# ============================================================================
. ~/.theme.zsh

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================
export EDITOR=nvim
export HOMEBREW_NO_AUTO_UPDATE=1

export FETCH_IDE=goland
export FETCH_TEMPLATE=template
export FETCH_FILES=1.go

# ============================================================================
# HISTORY
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY       # record epoch + duration against each command
setopt INC_APPEND_HISTORY     # write as you go, not only on shell exit
setopt SHARE_HISTORY          # one history across concurrent shells
setopt HIST_IGNORE_DUPS       # drop consecutive repeats, keep the rest
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE      # a leading space keeps a command out of history
setopt HIST_VERIFY            # expand !! for confirmation instead of running it

# ============================================================================
# PATH CONFIGURATION
# ============================================================================
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin

export PATH=$PATH:/opt/homebrew/opt/swagger-codegen@2/bin
export PATH=$PATH:/opt/homebrew/opt/node@22/bin
export PATH=$PATH:/opt/homebrew/opt/ruby/bin
export PATH=$PATH:/opt/homebrew/opt/postgresql@18/bin

export DEVKITPRO=/opt/devkitpro
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=$PATH:$DEVKITPRO/tools/bin:$DEVKITARM/bin

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
source <(fzf --zsh)
load "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
load "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
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
gg() { ghq get "$1" || return; local q="${1%.git}"; q="${q#*://}"; q="${q#*@}"; zoxide add "$(ghq list -p -e "${q/://}")" }

helpme() { claude -p "$*" }

# ============================================================================
# ALIASES
# ============================================================================
alias wake="caffeinate -u -t 1"
alias dns="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias l="ls -AFGho"
alias c="cd ~"
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
alias grs="git sparse-checkout set"
alias gs="git s"
alias gsc="git sc"
alias gsm="git sm"
alias gt="git t"
alias gtp="git tp"
alias commit="git commit"

alias t="tmux"

