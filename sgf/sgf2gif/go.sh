#!/bin/sh 

USEAGE="usage: ./go.sh  <sgfFile>"

fMake() {
  make --eval="NAME=$1"
}

case $1 in
  *.sgf) fMake $1;;
  *) echo $USEAGE;;
esac
