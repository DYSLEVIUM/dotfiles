set fish_greeting
set -gx COLORTERM truecolor

fish_vi_key_bindings
# fish_default_key_bindings

theme_gruvbox dark hard

# default editor
set -x EDITOR nvim

# pfetch config
set -x PF_COL1 3
set -x PF_COL2 8
set -x PF_COL3 2

# bat config
set -x BAT_THEME gruvbox-dark
set -x K9S_CONFIG_DIR ~/.config/k9s

alias ls='exa --group-directories-first'
alias ll='exa -laF --icons'
alias tree='exa --tree'
alias cat='bat'
alias grep='grep --color=auto'
alias cc='clear'
alias cp='rsync -ivP'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='cd ..'
alias ...='cd ../..'
alias eip='curl ifconf.me'

# function aliases
function n --wraps nvim
    nvim $argv
end

function p --wraps pnpm
    pnpm $argv
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

## git
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

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
set --export --prepend PATH "/Users/pushpakantbehera/.rd/bin"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
