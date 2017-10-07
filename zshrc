HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd
# bindkey -v
zstyle :compinstall filename '/home/imain/.zshrc'
autoload -Uz compinit
compinit
bindkey '^R' history-incremental-search-backward

# All this for a prompt eh?
autoload -U colors && colors

# Colors based on hostname
hostcolor="%{$bg[red]%}%{$fg[black]%}"
dircolor="%{$bg[white]%}%{$fg[black]%}"
vcscolor="%{$bg[cyan]%}%{$fg[black]%}"

# git info..
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# I only care about branch
zstyle ':vcs_info:git*' actionformats "%b"
# zstyle ':vcs_info:git*' formats "[%r:%b]"
zstyle ':vcs_info:git*' formats "%b"
precmd () {
    vcs_info
}
setopt prompt_subst

# vi mode insert/normal indicator
function zle-line-init zle-keymap-select {
    PS1="$hostcolor %? $dircolor %~ $vcscolor $vcs_info_msg_0_ $%{$reset_color%} "
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1


# set environment variables if user's agent already exists
[ -z "$SSH_AUTH_SOCK" ] && SSH_AUTH_SOCK=$(ls -l /tmp/ssh-*/agent.* 2> /dev/null | grep $(whoami) | awk '{print $9}')

ssh_agent_pid=`echo $SSH_AUTH_SOCK | cut -d . -f2 | head -n 1` 
if [ -z "$SSH_AGENT_PID" ] && [ -n "$ssh_agent_pid" ]; then
  echo "Setting existing ssh agent pid to '$ssh_agent_pid'."
  SSH_AGENT_PID=`expr $ssh_agent_pid + 1`
fi
[ -n "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK
[ -n "$SSH_AGENT_PID" ] && export SSH_AGENT_PID

# start agent if necessary
if [ -z $SSH_AGENT_PID ]; then
  echo "Starting ssh-agent"
  eval `ssh-agent -s` > /dev/null
fi

# setup addition of keys when needed
if [ -z "$SSH_TTY" ] ; then                     # if not using ssh
  ssh-add -l > /dev/null                        # check for keys
  if [ $? -ne 0 ] ; then
    alias ssh='ssh-add -l > /dev/null || ssh-add && unalias ssh ; ssh'
    if [ -f "/usr/lib/ssh/x11-ssh-askpass" ] ; then
      SSH_ASKPASS="/usr/lib/ssh/x11-ssh-askpass" ; export SSH_ASKPASS
    fi
  fi
fi
