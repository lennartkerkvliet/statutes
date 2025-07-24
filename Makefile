# Variables
PANDOC = pandoc
PDF_ENGINE = xelatex
FONT_SIZE = 11pt
HEADER = config/header.tex
LINK_FILTER = config/custom-links.lua

# Source and output files
BUILD_FOLDER = build
STATUTES_MD = statutes.md
RULES_MD = rules-of-procedure.md
INTERNAL_REGULATIONS_MD = internal-regulations.md
STATUTES_PDF = statutes.pdf
RULES_PDF = rules-of-procedure.pdf
INTERNAL_REGULATIONS_PDF = internal-regulations.pdf

# Default target
all: $(BUILD_FOLDER)/$(STATUTES_PDF) $(BUILD_FOLDER)/$(RULES_PDF) $(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF)

# Ensure the build folder exists
$(BUILD_FOLDER):
	mkdir -p $(BUILD_FOLDER)

# Rule for statutes PDF
$(BUILD_FOLDER)/$(STATUTES_PDF): $(STATUTES_MD) $(HEADER) $(LINK_FILTER) $(HEADER_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(STATUTES_MD) -o $(BUILD_FOLDER)/$(STATUTES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for rules of procedure PDF
$(BUILD_FOLDER)/$(RULES_PDF): $(RULES_MD) $(HEADER) $(LINK_FILTER) $(HEADER_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(RULES_MD) -o $(BUILD_FOLDER)/$(RULES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for internal regulations PDF
$(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF): $(INTERNAL_REGULATIONS_MD) $(HEADER) $(LINK_FILTER) $(HEADER_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(INTERNAL_REGULATIONS_MD) -o $(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Clean target
clean:
	rm -rf $(BUILD_FOLDER)

# Phony targets
.PHONY: all clean
