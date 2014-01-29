#!/bin/sh
git add --all .
git commit --all -m "$(date)"
git push -v
cd ..
cd ACMPS
git add --all .
git commit --all -m "$(date)"
git push -v
exit
