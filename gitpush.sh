#!/bin/sh
git add .
git commit --all -m "$(date)"
git push -v
cd ..
cd ACMPS
git add .
git commit --all -m "$(date)"
git push -v
exit
