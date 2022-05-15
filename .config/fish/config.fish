set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Default editor
export EDITOR=nvim

# Aliases
alias ls='exa -la'
alias tree='exa --tree'
alias cat='bat'
alias grep='grep --color=auto'

starship init fish | source

# Running pfetch
pfetch
