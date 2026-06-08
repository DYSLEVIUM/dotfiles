set fish_greeting

set --global fish_key_bindings fish_vi_key_bindings
set --erase --universal fish_key_bindings

# default editor
set -x EDITOR nvim

# bat config
set -x BAT_THEME gruvbox-dark

# fzf config
set -x FZF_DEFAULT_OPTS '--style=full --cycle --layout=reverse --height=90% --preview-window=wrap --marker="*"'

alias ls='eza --group-directories-first --icons'
alias ll='eza -laF --icons'
alias tree='eza --tree --icons'
alias cat='bat -p'
alias grep='grep --color=auto'
alias cc='clear'
alias cp='rsync -ivP'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias eip='curl ifconf.me'

# custom functions
function mkcd --description "Create directory and change to that path"
    command mkdir -p $argv
    cd $argv
end

function fish_user_key_bindings
    bind \cr fzf_history
    bind \co wrap_fzf_file
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

function sudo --description "Replacement for Bash 'sudo !!' command to run last command using sudo."
    if test "$argv" = !!
        eval command sudo $history[1]
    else
        command sudo $argv
    end
end

# Term
set --export TERM xterm-256color

# startup
starship init fish | source

# pfetch config
set -x PF_COL1 3
set -x PF_COL2 8
set -x PF_COL3 2

if status is-interactive
    pfetch
end

# devbar-managed-start
set -gx NODE_EXTRA_CA_CERTS "$HOME/.devbar/certs/corporate-ca-bundle.pem"
# devbar-managed-end
