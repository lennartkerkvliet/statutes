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
MANIFESTO_MD = manifesto.md
CODE_OF_CONDUCT_MD = code-of-conduct.md
STATUTES_PDF = statutes.pdf
RULES_PDF = rules-of-procedure.pdf
INTERNAL_REGULATIONS_PDF = internal-regulations.pdf
MANIFESTO_PDF = manifesto.pdf
CODE_OF_CONDUCT_PDF = code-of-conduct.pdf

# Default target
all: $(BUILD_FOLDER)/$(STATUTES_PDF) $(BUILD_FOLDER)/$(RULES_PDF) $(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF) $(BUILD_FOLDER)/$(MANIFESTO_PDF) $(BUILD_FOLDER)/$(CODE_OF_CONDUCT_PDF)

# Ensure the build folder exists
$(BUILD_FOLDER):
	mkdir -p $(BUILD_FOLDER)

# Rule for statutes PDF
$(BUILD_FOLDER)/$(STATUTES_PDF): $(STATUTES_MD) $(HEADER) $(LINK_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(STATUTES_MD) -o $(BUILD_FOLDER)/$(STATUTES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for rules of procedure PDF
$(BUILD_FOLDER)/$(RULES_PDF): $(RULES_MD) $(HEADER) $(LINK_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(RULES_MD) -o $(BUILD_FOLDER)/$(RULES_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for internal regulations PDF
$(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF): $(INTERNAL_REGULATIONS_MD) $(HEADER) $(LINK_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(INTERNAL_REGULATIONS_MD) -o $(BUILD_FOLDER)/$(INTERNAL_REGULATIONS_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for manifesto PDF
$(BUILD_FOLDER)/$(MANIFESTO_PDF): $(MANIFESTO_MD) $(HEADER) $(LINK_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(MANIFESTO_MD) -o $(BUILD_FOLDER)/$(MANIFESTO_PDF) \
		--pdf-engine=$(PDF_ENGINE) \
		--number-sections \
		-V fontsize=$(FONT_SIZE) \
		-H $(HEADER) \
		--lua-filter=$(LINK_FILTER)

# Rule for code of conduct PDF
$(BUILD_FOLDER)/$(CODE_OF_CONDUCT_PDF): $(CODE_OF_CONDUCT_MD) $(HEADER) $(LINK_FILTER) | $(BUILD_FOLDER)
	$(PANDOC) $(CODE_OF_CONDUCT_MD) -o $(BUILD_FOLDER)/$(CODE_OF_CONDUCT_PDF) \
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
