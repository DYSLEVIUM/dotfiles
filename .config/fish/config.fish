set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# default editor
export EDITOR=nvim

# aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"

# starship
starship init fish | source

# neofetch
neofetch
