if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH="/usr/local/bin:$PATH"
  export PATH="/usr/local/sbin:$PATH"
fi

# oh-my-zsh tmux
export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTO_QUIT=false
export ZSH_TMUX_AUTOSTART_ONCE=true
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTONAME_SESSION=true

export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "zplug/zplug", hook-build: 'zplug --self-manage'
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "mafredri/zsh-async"

zplug 'dracula/zsh', as:theme

zplug "plugins/git", from:oh-my-zsh

zplug "plugins/docker-compose", from:oh-my-zsh

zplug "plugins/asdf", from:oh-my-zsh

zplug "plugins/tmux", from:oh-my-zsh

zplug "lib/history", from:oh-my-zsh

zplug "mollifier/anyframe"

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo
    zplug install
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

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit

alias readlink='greadlink'
alias awk='gawk'
alias sed='gsed'
alias date='gdate'

# jump
eval "$(jump shell)"

# direnv
eval "$(direnv hook zsh)"
