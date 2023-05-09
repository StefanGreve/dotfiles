# ==============================================================================
# author: stefangreve <greve.stefan@outlook.jp>
# ==============================================================================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ==============================================================================
# auto-start
# ==============================================================================

eval $(ssh-agent) > /dev/null 2>&1

# ==============================================================================
# shell variables
# ==============================================================================

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a'
HISTSIZE=10000
HISTFILESIZE=10000000
# don't put duplicate lines or lines starting with space in the history
HISTCONTROL='ignoreboth'

# ==============================================================================
# environment variables
# ==============================================================================

export GPG_TTY=$(tty)
export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
export USE_EMOJI=0
export LANG=en_US.UTF-8
export VIRTUAL_ENV_DISABLE_PROMPT=1

# ==============================================================================
# miscellaneous settings and functions
# ==============================================================================

[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases

track_all_branches() {
    local is_inside_work_tree=$(git rev-parse --is-inside-work-tree 2>/dev/null)

    if [ "$is_inside_work_tree" ]; then
        git branch -r | grep -v "origin/master" | tr -d ' ' | cut -d '/' -f2 | while read branch
        do
            git checkout --track "origin/$branch" 2>/dev/null
        done
    else
        local err_msg="error: not a git repository (or any of the parent directories)"
        printf "$(tput setaf 196)$err_msg$(tput sgr 0)\n"
    fi
}

# ==============================================================================
# prompt configuration
# ==============================================================================

parse_git_branch() {
    local branch=''
    local is_inside_work_tree=$(git rev-parse --is-inside-work-tree 2>/dev/null)

    if [ "$is_inside_work_tree" = true ]; then
        branch="($(git branch --show-current))"
    fi

    printf "%s" $branch
}

parse_venv() {
    local venv=''

    if [ -n "$VIRTUAL_ENV" ]; then
        venv="(${VIRTUAL_ENV##*/})"
    fi

    printf "%s" $venv
}

# [username@hostname]
PS1='[$(tput setaf 43)\u$(tput sgr 0)@\h $(tput setaf 41)\W$(tput sgr 0)]'
# (branch)
PS1+='$(tput setaf 184) $(parse_git_branch)$(tput sgr 0)'
# (venv)
PS1+='$(tput setaf 69) $(parse_venv)$(tput sgr 0)'
PS1+='\n> '
