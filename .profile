# Init
echo -e "\
##################################################\n\
# Remember:\n\
# 1. Focus on what is the most significant\n\
# 2. Done first, perfect second.\n\
# 3. Life is short, so script first.\n\
# 4. Try the easier version if stucked.\n\
# 5. Concision, expressiveness, ease, transparency\n\
#    and scriptability.\n\
#################################################\n"

# Export 
## Basic
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
## C/C++
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export LD_RUN_PATH=$HOME/.local/lib:$LD_RUN_PATH
export C_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
export CPLUS_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
## Java
export JAVA_HOME=$HOME/Downloads/jdk
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar
## TeX
export TEXHOME=/usr/local/texlive/2013
export MANPATH=$MANPATH:$TEXHOME/texmf-dist/doc/man
export PATH=$PATH:$TEXHOME/bin/i386-linux

# if [[ -n $(pidof xbindkeys) ]]; then
# 	killall xbindkeys
# fi
# xbindkeys

# Alias
alias ..="cd .."
alias ...="cd ..; cd .."
alias ll="ls -lh"
alias la="ls -lah"
## Directory
alias cde="cd $HOME/env"
alias cdp="cd $HOME/project"
alias cdd="cd $HOME/Desktop"
alias cdm="cd $HOME/Music"
alias cdo="cd $HOME/Downloads"
alias cdv="cd $HOME/Videos"
## Core Tools
alias cpr="cp -rf"
alias mkdp="mkdir -p"
alias rmr="rm -rf"
alias pst="pstree $USER"
alias psg="ps aux | grep -v grep | grep"
alias envg="env | grep"
alias ka="killall"
alias dush="du -sh"
## Application
alias mpgl="mpg123 -C -z *"
### Git
alias gitcl="tsocks git clone"
alias gitpl="tsocks git pull -v"
alias gitph="tsocks git push -v"
alias gitpl="tsocks git pull -v"
alias gitcm="git commit -a"
alias gitco="git checkout"
alias gitbr="git branch"
alias gitaa="git add --all"
