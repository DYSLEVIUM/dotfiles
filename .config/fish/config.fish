set fish_greeting
fish_vi_key_bindings

# default editor
set -x EDITOR nvim

# pfetch config
set -x PF_ASCII arch
set -x PF_COL1 1
set -x PF_COL2 8
set -x PF_COL3 3

# bat config
set -x BAT_THEME gruvbox-dark

# aliases
alias ls='exa'
alias ll='exa -la'
alias tree='exa --tree'
alias cat='bat -p'
alias grep='grep --color=auto'
alias docker='sudo docker'
alias cc='clear'
alias n='nvim'

function wrap_fzf_file
  fzf_file --preview "bat --style=numbers --color=always --line-range :500 {}"
end

function fish_user_key_bindings
  bind \cr fzf_history
  bind \co wrap_fzf_file
end

starship init fish | source

# running pfetch
pfetch

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
    eval command sudo $history[1]
else
    command sudo $argv
    end
end

# Bun
set -Ux BUN_INSTALL "/home/dyslevium/.bun"
set -px --path PATH "/home/dyslevium/.bun/bin"
