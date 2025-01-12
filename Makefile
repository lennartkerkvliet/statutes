# Variables
PANDOC = pandoc
PDF_ENGINE = xelatex
FONT_SIZE = 11pt
HEADER = config/header.tex
FILTER = config/custom-links.lua

# Source and output files
BUILD_FOLDER = build
STATUTES_MD = statutes.md
RULES_MD = rules-of-procedure.md
STATUTES_PDF = statutes.pdf
RULES_PDF = rules-of-procedure.pdf

# Default target
all: $(STATUTES_PDF) $(RULES_PDF)

# Rule for statutes PDF
$(STATUTES_PDF): $(STATUTES_MD) $(HEADER) $(FILTER)
	$(PANDOC) $(STATUTES_MD) -o $(BUILD_FOLDER)/$(STATUTES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(FILTER)

# Rule for rules of procedure PDF
$(RULES_PDF): $(RULES_MD) $(HEADER) $(FILTER)
	$(PANDOC) $(RULES_MD) -o $(BUILD_FOLDER)/$(RULES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(FILTER)

# Install dependencies
dependencies:
	sudo apt-get update && sudo apt-get install -y pandoc texlive-xetex texlive-latex-extra texlive-fonts-extra

# Clean target
clean:
	rm $(BUILD_FOLDER)

# Phony targets
.PHONY: all clean