#!/bin/bash

set -e

pushd /latex/disc

pdflatex disc.tex
bibtex disc
pdflatex disc.tex
pdflatex disc.tex

popd

cd /latex
pdflatex caspaxos.tex
bibtex caspaxos
pdflatex caspaxos.tex
pdflatex caspaxos.tex