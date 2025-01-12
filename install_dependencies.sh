#!/bin/bash

# Install TeX Live (minimal)
echo "Installing TeX Live..."
mkdir -p texlive && cd texlive
wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz --strip-components=1
./install-tl --profile=../config/texlive.profile
export PATH=$(pwd)/bin/x86_64-linux:$PATH
cd ..

# Install required LaTeX packages
echo "Installing required LaTeX packages..."
texlive/bin/x86_64-linux/tlmgr install \
  xetex fontspec xunicode xltxtra graphicx fancyhdr titlesec tocloft
texlive/bin/x86_64-linux/tlmgr install FiraSans FiraMono

# Verify xelatex installation
echo "Verifying xelatex installation..."
texlive/bin/x86_64-linux/xelatex --version || { echo "xelatex installation failed!"; exit 1; }
