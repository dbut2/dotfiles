# Set colors
autoload -U colors && colors

# Enable prompt substitution
setopt prompt_subst

# Function to get current git branch
get_git_info() {
    local branch_name commit_hash dirty
    # Check if we are in a git repository
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Attempt to get the current branch name; fall back to HEAD if detached
        branch_name=$(git symbolic-ref --short HEAD 2>/dev/null)
        commit_hash=$(git rev-parse --short HEAD 2>/dev/null)

        # Check for uncommitted changes
        if git diff --quiet && git diff --staged --quiet 2>/dev/null; then
            dirty=''
        else
            dirty='*'
        fi

        if [[ -n "$branch_name" ]]; then
            echo "[ $branch_name$dirty | $commit_hash ]"  # Display branch and commit hash
        elif [[ -n "$commit_hash" ]]; then
            echo "[ $commit_hash ]"  # Detached HEAD, only display commit hash
        fi
    fi
}

# Determine user and host display
if [[ $EUID -eq 0 ]]; then
  # Root user settings
  PROMPT_USERNAME="%B%F{red}%n"
  PROMPT_LIBERTY="%F{red}#"
else
  # Regular user settings
  PROMPT_USERNAME="%B%F{white}%n"
  PROMPT_LIBERTY="%F{green}$"
fi
PROMPT_USERNAME="$PROMPT_USERNAME%{$reset_color%}@%m"
PROMPT_LIBERTY="$PROMPT_LIBERTY%{$reset_color%}"

# Path with dynamic Git information
PROMPT_PATH="%{$fg_bold[white]%}%~%{$reset_color%}"

PROMPT_LEFT="$PROMPT_USERNAME $PROMPT_PATH"

# Assemble the prompt
PROMPT='
${PROMPT_LEFT} $(get_git_info)
> ${PROMPT_LIBERTY} '
