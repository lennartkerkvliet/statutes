# Statutes and Rules of Procedure 

The idea is to automate the process of updating the statutes and rules of procedure as much as possible. The current wokflow using GitHub action and pandoc to convert markdown source files into LaTeX pdfs. This can be easily updated so that the output files are uploaded directly to the website.

# How to build the Statutes and Rules of Procedure locally

1. Clone the repository.
```
git clone https://github.com/iflry/statutes.git
cd statutes 
```

2. Ensure [Pandoc](https://pandoc.org/) is installed. 

On Mac:
```
brew install pandoc
```
On Linux:
```
sudo apt-get install -y pandoc
```

3. Ensure [XeLaTeX](https://ctan.org/pkg/xetex?lang=en) is installed. 

On Mac:
```
brew install texlive
```
On Linux
```
sudo apt-get install -y texlive-xetex texlive-latex-extra
```
You may also need to install `texlive-fonts-extra` so that the Fira font is available.

4. Build the documents.
```
pandoc statutes.md -o statutes.pdf --pdf-engine=xelatex --number-sections -V fontsize=11pt -H config/header.tex --lua-filter=config/custom-links.lua
pandoc rules-of-procedure.md -o rules-of-procedure.pdf --pdf-engine=xelatex --number-sections -V fontsize=11pt -H config/header.tex --lua-filter=config/custom-links.lua 
```