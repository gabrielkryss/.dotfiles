if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -Ux EDITOR nvim
set fish_greeting ""
export PATH="$HOME/.cargo/bin:$PATH" # sourcing ~/.cargo/env, see https://github.com/rust-lang/rustup/issues/478

if which exa >/dev/null
    alias ls='exa -alBh@ --color auto --icons --time=modified --time-style=default --color-scale'
end

bind \cf 'jump'

starship init fish | source
