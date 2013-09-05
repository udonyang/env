#!/bin/sh
git add .
git commit -a -m "$(date)"
git push -v
cd ..
cd ACMPS
git add .
git commit -a -m "$(date)"
git push -v
exit
