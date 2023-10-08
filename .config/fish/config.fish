set fish_greeting
set -gx COLORTERM truecolor

fish_vi_key_bindings
# fish_default_key_bindings

theme_gruvbox dark medium

# default editor
set -x EDITOR nvim

# pfetch config
set -x PF_COL1 3
set -x PF_COL2 8
set -x PF_COL3 2

# bat config
set -x BAT_THEME gruvbox-dark

alias ls='exa -a'
alias ll='exa -laF --icons'
alias tree='exa --tree'
alias cat='bat'
alias grep='grep --color=auto'
alias docker='sudo docker'
alias cc='clear'
alias n='nvim'
alias cp='rsync -ivP'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias eip='curl ifconf.me'
alias p='pnpm'

function mkcd --description "Create directory and change to that path"
    command mkdir -p $argv
    cd $argv
end

function wrap_fzf_file
    fzf_file --preview "bat --style=numbers --color=always --line-range :500 {}"
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

# startup
starship init fish | source
pfetch
