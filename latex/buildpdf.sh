#!/bin/bash

set -e

rm /latex/caspaxos.pdf || true
rm /latex/disc.pdf || true
rm /latex/arxiv.tar || true


pushd /latex/disc

pdflatex disc.tex
bibtex disc
pdflatex disc.tex
pdflatex disc.tex

popd

pushd /latex/arxiv

pdflatex caspaxos.tex
bibtex caspaxos
pdflatex caspaxos.tex
pdflatex caspaxos.tex

tar -cf arxiv.tar caspaxos.bbl caspaxos.tex cc-by.pdf lipics-logo-bw.pdf lipics-v2018.cls orcid.pdf

popd

mv /latex/arxiv/caspaxos.pdf /latex/
mv /latex/arxiv/arxiv.tar /latex/
mv /latex/disc/disc.pdf /latex/