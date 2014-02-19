export DHOME=/home/dwylkz

export JAVA_HOME=$DHOME/Downloads/jdk
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar

export TEXHOME=/usr/local/texlive/2013
export MANPATH=$MANPATH:$TEXHOME/texmf-dist/doc/man
export PATH=$PATH:$TEXHOME/bin/i386-linux

setxkbmap -option caps:swapescape
xbindkeys -f $DHOME/.xbindkeysrc
