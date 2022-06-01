set fish_greeting
fish_vi_key_bindings

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Default editor
export EDITOR=nvim

# Aliases
alias ls='exa'
alias ll='exa -la'
alias tree='exa --tree'
alias cat='bat -p'
alias grep='grep --color=auto'
alias cc='clear'
alias n='nvim'

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

function wrap_fzf_file
  fzf_file --preview "bat --style=numbers --color=always --line-range :500 {}"
end

function fish_user_key_bindings
  bind \cr fzf_history
  bind \co wrap_fzf_file
end
