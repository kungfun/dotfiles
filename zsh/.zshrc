###############################################################################
# Created by newuser for 5.9

###############################################################################
# History file for zsh
autoload -U compinit && compinit
zstyle ':completion:*' menu select

HISTFILE=~/.zsh_history

HISTZISE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

bindkey '^ ' autosuggest-accept
bindkey '^I' complete-word

# Initialize Autocompletion
###############################################################################
# Plugins

## git clone https://github.com/zsh-users/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
## git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###############################################################################
# Promt

## Git Promt
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_STATESEPARATOR=' '
GIT_PS1_HIDE_IF_PWD_IGNORED=true
GIT_PS1_COMPRESSSPARSESTATE=true

# Usage: prompt-length TEXT [COLUMNS]
#
# If you run `print -P TEXT`, how many characters will be printed
# on the last line?
#
# Or, equivalently, if you set PROMPT=TEXT with prompt_subst
# option unset, on which column will the cursor be?
#
# The second argument specifies terminal width. Defaults to the
# real terminal width.
#
# Assumes that `%{%}` and `%G` don't lie.
#
# Examples:
#
#   prompt-length ''            => 0
#   prompt-length 'abc'         => 3
#   prompt-length $'abc\nxy'    => 2
#   prompt-length '❎'          => 2
#   prompt-length $'\t'         => 8
#   prompt-length $'\u274E'     => 2
#   prompt-length '%F{red}abc'  => 3
#   prompt-length $'%{a\b%Gb%}' => 1
#   prompt-length '%D'          => 8
#   prompt-length '%1(l..ab)'   => 2
#   prompt-length '%(!.a.)'     => 1 if root, 0 if not
function prompt-length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=$#1 m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ));
    done
    local xy
    while (( y > x + 1 )); do
      m=$(( x + (y - x) / 2 ))
      typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
    done
  fi
  echo $x
}

# Usage: fill-line LEFT RIGHT
#
# Prints LEFT<spaces>RIGHT with enough spaces in the middle
# to fill a terminal line.
function fill-line() {
  emulate -L zsh
  local left_len=$(prompt-length $1)
  local right_len=$(prompt-length $2 9999)
  local pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
  if (( pad_len < 1 )); then
    # Not enough space for the right part. Drop it.
    echo -E - ${1}
  else
    local pad=${(pl.$pad_len.. .)}  # pad_len spaces
    echo -E - ${1}${pad}${2}
  fi
}

# Sets PROMPT and RPROMPT.
#
# Requires: prompt_percent and no_prompt_subst.
function set-prompt() {
  emulate -L zsh
  local git_branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  git_branch=${${git_branch//\%/%%}/\\/\\\\\\}  # escape '%' and '\'

  local top_left='%F%n %~%f'
  local top_right="%F${git_branch}%f"
  local bottom_left='%B%F{%(?.green.red)}%#%f%b '

  PROMPT="$(fill-line "$top_left" "$top_right")"$'\n'$bottom_left
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd set-prompt
setopt noprompt{bang,subst} prompt{cr,percent,sp}

###############################################################################
# Env

## Bin
export PATH=$HOME/.local/bin:$PATH

## Lang

### Rust
export PATH=$HOME/.cargo/bin:$PATH

### Golang
export PATH=$PATH:/usr/local/go/bin

### RISC-V
export PATH=$PATH:/opt/riscv/bin
export PATH=$PATH:/opt/riscv/musl/bin
export PATH=$PATH:/opt/riscv/gnu/bin
export PATH=$PATH:/opt/riscv/elf/bin

### CMAKE
export PATH=$PATH:/opt/cmake/bin

### Ninja
export PATH=$PATH:/home/user19/bin/ninja

### LLVM
export PATH=$PATH:/home/user19/bin/llvm-project-19/build-release/bin

###############################################################################
# Aliases

