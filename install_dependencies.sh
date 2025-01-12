#!/bin/bash

# Install texlive-xetex
echo "Installing texlive-xetex..."
mkdir -p texlive && cd texlive
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz --strip-components=1
./install-tl --profile=../config/texlive.profile
export PATH=$(pwd)/bin/x86_64-linux:$PATH
cd ..

# Install required LaTeX packages
echo "Installing required LaTeX packages..."
tlmgr install xetex fontspec xunicode xltxtra graphicx fancyhdr titlesec tocloft
tlmgr install FiraSans FiraMono

# Verify xelatex installation
xelatex --version || { echo "xelatex installation failed!"; exit 1; }
