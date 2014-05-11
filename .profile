# Init
echo "Hey, remember:"
echo "	Focus on what is import."
echo "	Done first, perfect second."
echo "	Life is short, so use script,"
echo "		except you are solving ACM problem."

export EDITOR=vim
export PATH=$HOME/.local/bin:$PATH
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
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
alias rmr="rm -rf"
alias pst="pstree $USER"
alias psg="ps aux | grep -v grep | grep"
alias ka="killall"
