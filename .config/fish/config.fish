set fish_greeting

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Default editor
export EDITOR=nvim

# Aliases
alias ls='exa'
alias ll='exa -la'
alias tree='exa --tree'
alias cat='bat'
alias grep='grep --color=auto'
alias fzf='fzf --preview \'bat --color "always" {}\''

starship init fish | source

# Running pfetch
pfetch

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end
