# >>> nvm
set -gx NVM_DIR $HOME/.nvm
function nvm
    bash -c "source ~/.nvm/nvm.sh; nvm $argv"
end
# <<< nvm

# >>> bun
set -gx BUN_INSTALL $HOME/.bun
set -gx PATH $BUN_INSTALL/bin $PATH
# <<< bun

# >>> rust
set -gx PATH ~/.cargo/bin $PATH
if test -f "$HOME/.cargo/env"
    bash -c "source ~/.cargo/env"
end
# <<< rust

# >>> conda
if test -f /Users/kungfun/miniconda3/bin/conda
    eval /Users/kungfun/miniconda3/bin/conda "shell.fish" "hook" | source
else
    set -gx PATH /Users/kungfun/miniconda3/bin $PATH
end
# <<< conda

# >>> uv
set -gx PATH /Users/kungfun/.local/bin $PATH
# <<< uv

