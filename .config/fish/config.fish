set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Default editor
export EDITOR=nvim

# Aliases
alias ls='exa'
alias ll='exa -lah'
alias ls='exa --tree'
alias grep='grep --color=auto'

starship init fish | source

# Running pfetch
pfetch
