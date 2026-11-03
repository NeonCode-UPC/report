# =============================================================================
# Makefile — Docs-as-Code Pipeline (Pandoc)
# UPC — Carrera de Ingeniería de Software | 1ASI0730 Aplicaciones Web
# Proyecto: Medical SMARTBOX (Equipo NeonCode)
# =============================================================================

PANDOC      ?= pandoc
BUILD_DIR   := build
CONFIG_FILE := config/build.yaml
EISVOGEL_CF := config/eisvogel.yaml
OUTPUT_PDF  := $(BUILD_DIR)/upc-pre-202620-1asi0730-8150-neoncode-report-tb1.pdf
REPORT_PDF  := $(BUILD_DIR)/project-report.pdf

.PHONY: all pdf eisvogel clean help

all: pdf

pdf:
	@echo "==> Compiling modular Markdown report via Pandoc ($(CONFIG_FILE))..."
	@$(PANDOC) --defaults=$(CONFIG_FILE)
	@cp -f $(OUTPUT_PDF) $(REPORT_PDF)
	@echo "==> Build successful: $(OUTPUT_PDF) & $(REPORT_PDF)"

eisvogel:
	@echo "==> Compiling modular Markdown report via Pandoc + Eisvogel ($(EISVOGEL_CF))..."
	@$(PANDOC) --defaults=$(EISVOGEL_CF)
	@echo "==> Build successful: $(OUTPUT_PDF)"

clean:
	@echo "==> Cleaning build directory..."
	@rm -rf $(BUILD_DIR)/*.pdf

help:
	@echo "Targets disponibles:"
	@echo "  make pdf      - Compila report/**/*.md a PDF usando config/build.yaml"
	@echo "  make eisvogel - Compila report/**/*.md a PDF usando plantilla Eisvogel + XeLaTeX"
	@echo "  make clean    - Elimina los artefactos PDF generados en build/"
