# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/carson/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"
export PATH=$PATH:/home/carson/Projects/depot_tools/:/home/carson

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

export JAVA_HOME=/usr/lib/jvm/java-8-oracle/jre
export GOPATH=$HOME/gocode

# Edit this file.
alias zshconfig="vim ~/.zshrc"
# OHMYZSH
alias ohmyzsh="vim ~/.oh-my-zsh"
# Git call for bare git dotfiles repo.
alias config="/usr/bin/git --git-dir=/home/carson/.cfg/ --work-tree=/home/carson"
# Sudo, but run with current user in path.
alias sudh='sudo -H'
# Tree, but ignore items in .gitignore.
alias gtree="tree -I \"\$(tr '\\n' '\|' < \".gitignore\" )\" \"\${@}\""
# Go to projects directory.
alias cdp="cd ~/Projects"
# Ag ps
alias psag="ps -aux | ag -v 'ag ' | ag"

# Let's get zplug going.
source $HOME/.zplug/init.zsh

