if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
fi

source ~/.zplug/init.zsh
zplug "zplug/zplug", hook-build: 'zplug --self-manage'
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "mafredri/zsh-async"

zplug 'dracula/zsh', as:theme

zplug "plugins/git", from:oh-my-zsh

zplug "plugins/docker-compose", from:oh-my-zsh

zplug "lib/history", from:oh-my-zsh

zplug "mollifier/anyframe"

zplug "mattn/efm-langserver", as:command, rename-to:efm-langserver, from:gh-r
zplug "mattn/memo", as:command, rename-to:memo, from:gh-r

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
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
# stack
export PATH="$HOME/.local/bin:$PATH"
eval "$(stack --bash-completion-script stack)"

alias readlink='greadlink'
alias awk='gawk'
alias sed='gsed'
alias date='gdate'
