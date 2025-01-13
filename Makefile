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
all: $(BUILD_FOLDER)/$(STATUTES_PDF) $(BUILD_FOLDER)/$(RULES_PDF)

# Ensure the build folder exists
$(BUILD_FOLDER):
	mkdir -p $(BUILD_FOLDER)

# Rule for statutes PDF
$(BUILD_FOLDER)/$(STATUTES_PDF): $(STATUTES_MD) $(HEADER) $(FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(STATUTES_MD) -o $(BUILD_FOLDER)/$(STATUTES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(FILTER)

# Rule for rules of procedure PDF
$(BUILD_FOLDER)/$(RULES_PDF): $(RULES_MD) $(HEADER) $(FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(RULES_MD) -o $(BUILD_FOLDER)/$(RULES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(FILTER)

# Clean target
clean:
	rm -rf $(BUILD_FOLDER)

# Phony targets
.PHONY: all clean
