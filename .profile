# Init
echo -e "\
#################################################\n\
# Remember:\n\
# 1. Focus on what is the most significant\n\
# 2. Done first, perfect second.\n\
# 3. Life is short, so script first.\n\
# 4. Try the easier version if stucked.\n\
#################################################\n"

export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
export LC_ALL=en_US.UTF-8

if [[ -z $(pidof xbindkeys) ]]; then
	xbindkeys
fi

# Alias
alias ..="cd .."
alias ...="cd ..; cd .."
alias ll="ls -l"
alias la="ls -la"
alias cdp="cd $HOME/Project"
alias cdd="cd $HOME/Desktop"
alias cdo="cd $HOME/Downloads"
alias cdv="cd $HOME/Videos"
alias mus="nohup make -C $HOME/Music > /dev/null 2>&1&"
alias cpr="cp -rf"
alias mkdp="mkdir -p"
alias rmr="rm -rf"
alias pst="pstree $USER"
alias psg="ps aux | grep -v grep | grep"
alias envg="env | grep"
alias ka="killall"
alias dush="du -sh"
