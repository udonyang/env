#!/bin/sh
git add .
git commit -m "$(date)"
git push -v
cd ..
cd ACMPS
git add .
git commit -m "$(date)"
git push -v
exit
