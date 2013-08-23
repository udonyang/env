#!/bin/sh
git add .
git commit -m "$(date)"
tsocks git push -v
cd ..
cd ACMPS
git add .
git commit -m "$(date)"
tsocks git push -v
exit
