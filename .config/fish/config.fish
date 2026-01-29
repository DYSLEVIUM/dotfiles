set fish_greeting

set --global fish_key_bindings fish_vi_key_bindings
set --erase --universal fish_key_bindings

# default editor
set -x EDITOR nvim

# pfetch config
set -x PF_COL1 3
set -x PF_COL2 8
set -x PF_COL3 2

# bat config
set -x BAT_THEME gruvbox-dark

# k9s config
set -x K9S_CONFIG_DIR ~/.config/k9s

alias ls='eza --group-directories-first'
alias ll='eza -laF --icons'
alias tree='eza --tree'
alias cat='bat -p'
alias grep='grep --color=auto'
alias cc='clear'
alias cp='rsync -ivP'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias eip='curl ifconf.me'

# function aliases
function z --wraps zoxide
    zoxide $argv
end

function n --wraps nvim
    nvim $argv
end

function pm --wraps podman
    podman $argv
end

function k --wraps kubectl
    kubectl $argv
end

function tf --wraps terraform
    terraform $argv
end

function h --wraps helm
    helm $argv
end

## git
function g --wraps git
    git $argv
end

function ga --wraps git
    git add $argv
end

function gs --wraps git
    git status $argv
end

function gm --wraps git
    git merge $argv
end

function gcm --wraps git
    git commit -m $argv
end

function gch --wraps git
    git checkout $argv
end

function gchb --wraps git
    git checkout -b $argv
end

function gb --wraps git
    git branch $argv
end

function gba --wraps git
    git branch -av $argv
end

function gbd --wraps git
    git branch -d $argv
end

function gp --wraps git
    git push $argv
end

function gpo --wraps git
    git push origin $argv
end

function gch --wraps git
    git checkout $argv
end

# custom functions
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

# Term
set --export TERM xterm-256color

# homebrew
set --export PATH /opt/homebrew/bin $PATH

# golang
set --export PATH /Users/pushpakantbehera/go/bin $PATH

# startup
starship init fish | source
pfetch

# pyenv
set -Ux PYENV_ROOT $HOME/.pyenv

# Add pyenv to PATH if not already there
if not contains $PYENV_ROOT/bin $PATH
    set -Ux PATH $PYENV_ROOT/bin $PATH
end

# Initialize pyenv
pyenv init - | source
pyenv virtualenv-init - | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
set -gx ANDROID_HOME ~/Library/Android/sdk
set -gx JAVA_HOME /opt/homebrew/opt/openjdk@17

if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/homebrew/anaconda3/bin $PATH
    end
end
