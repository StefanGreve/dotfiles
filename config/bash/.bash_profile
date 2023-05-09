# ==============================================================================
# login shell
# ==============================================================================

export GPG_TTY=$(tty)
export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
export USE_EMOJI=0
export LANG=en_US.UTF-8
export VIRTUAL_ENV_DISABLE_PROMPT=1

export CARGO=~/.cargo
# PATH can have several paths separated by a colon
export PATH="$PATH:$CARGO/bin"

[ -f ~/.bashrc ] && . ~/.bashrc
