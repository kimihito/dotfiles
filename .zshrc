setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt share_history
setopt append_history
setopt inc_append_history
setopt hist_no_store

source ~/.zplug/init.zsh
zplug "zplug/zplug", hook-build: 'zplug --self-manage'
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "mafredri/zsh-async"

zplug 'dracula/zsh', as:theme

zplug "plugins/git", from:oh-my-zsh

zplug "mollifier/anyframe"

zplug "mattn/efm-langserver", as:command, rename-to:efm-langserver, :from:gh-r

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# anyframe
zstyle ":anyframe:selector:" use fzf
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

bindkey '^r' anyframe-widget-execute-history
bindkey '^]' anyframe-widget-cd-ghq-repository
bindkey '^b' anyframe-widget-checkout-git-branch

# tmux
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

# anyenv
eval "$(anyenv init -)"
