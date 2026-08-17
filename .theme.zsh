setopt prompt_subst

# Per-segment colours. Any zsh colour name or 0-255 works; 8 is the terminal's
# grey, so it dims with your theme rather than fighting it.
PROMPT_C_USER=8       # dylan@host — rarely the thing you're reading
PROMPT_C_MARKER=cyan  # the @ or ~/ prefix
PROMPT_C_PATH=white   # bold
PROMPT_C_GIT=8        # the [ ] and | chrome
PROMPT_C_BRANCH=yellow
PROMPT_C_DIRTY=red    # the * on uncommitted changes
PROMPT_C_HASH=8
PROMPT_C_SIGIL=green  # the $

# Path prefixes collapsed to a marker character. First match wins, so keep the
# deepest paths first. The marker carries its own separator, so '@' gives
# @user/repo while '~/' keeps ~/Downloads.
PROMPT_PATH_MARKERS=(
  "$HOME/ghq/github.com" '@'
  "$HOME"                '~/'
)

# %~ can only ever produce ~name, so build the path by hand before each prompt.
# %% throughout so a directory or branch name can't act as a prompt escape.
set_prompt_path() {
    local dir=$PWD prefix marker head='' tail=$PWD
    for prefix marker in $PROMPT_PATH_MARKERS; do
        if [[ $dir == "$prefix" ]]; then head=${marker%/} tail=''; break
        elif [[ $dir == "$prefix"/* ]]; then head=$marker tail=${dir#"$prefix"/}; break
        fi
    done
    PROMPT_PATH="%F{$PROMPT_C_MARKER}${head//\%/%%}%B%F{$PROMPT_C_PATH}${tail//\%/%%}%f%b"
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd set_prompt_path

# [ branch* | hash ], or [ hash ] when detached. Silent outside a repo.
get_git_info() {
    local hash branch dirty
    hash=$(git rev-parse --short HEAD 2>/dev/null) || return
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    git diff --quiet HEAD 2>/dev/null || dirty="%F{$PROMPT_C_DIRTY}*"
    [[ -n $branch ]] && branch="%F{$PROMPT_C_BRANCH}${branch//\%/%%}$dirty%F{$PROMPT_C_GIT} | "
    print -r -- "%F{$PROMPT_C_GIT}[ $branch%F{$PROMPT_C_HASH}$hash%F{$PROMPT_C_GIT} ]%f"
}

PROMPT='
%(!.%F{red}.%F{${PROMPT_C_USER}})%n@%m%f ${PROMPT_PATH} $(get_git_info)
> %(!.%F{red}#.%F{${PROMPT_C_SIGIL}}$)%f '
