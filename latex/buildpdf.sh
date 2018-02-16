#!/bin/bash

set -e

cd /latex
pdflatex caspaxos.tex
bibtex caspaxos
pdflatex caspaxos.tex
pdflatex caspaxos.tex