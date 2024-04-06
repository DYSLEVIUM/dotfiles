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
set -x K9S_CONFIG_DIR ~/.config/k9s

alias ls='exa -a'
alias ll='exa -laF --icons'
alias tree='exa --tree'
alias cat='bat'
alias grep='grep --color=auto'
alias cc='clear'
alias n='nvim'
alias cp='rsync -ivP'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias eip='curl ifconf.me'
alias p='pnpm'
alias pm='podman'
alias k='kubectl'
alias tf='terraform'

# git alisaes
alias ga="git add"
alias gs="git status"
alias gm="git merge"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gm="git merge"
alias gba="git branch -av"

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" hook $argv | source
end
# <<< conda initialize <<<

# pnpm
set -gx PNPM_HOME /Users/pushpakantbehera/Library/pnpm
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true
