SRC_DIR := src
OUT_DIR := out

LATEX := latex
DVISVGM := dvisvgm

SOURCES := $(wildcard $(SRC_DIR)/*.tex)
TARGETS := $(patsubst $(SRC_DIR)/%.tex,$(OUT_DIR)/%.svg,$(SOURCES))

all: $(TARGETS)

$(OUT_DIR)/%.svg: $(SRC_DIR)/%.tex
	@mkdir -p $(OUT_DIR)
	$(LATEX) -output-directory=$(OUT_DIR) -halt-on-error -interaction=batchmode $<
	$(DVISVGM) --no-fonts $(OUT_DIR)/$(<F:.tex=.dvi) --output=$@
	@$(MAKE) clean-temp

clean-temp:
	-rm -f $(OUT_DIR)/*.log $(OUT_DIR)/*.aux $(OUT_DIR)/*.dvi

clean:
	-rm -f $(OUT_DIR)/*.svg $(OUT_DIR)/*.log $(OUT_DIR)/*.aux $(OUT_DIR)/*.dvi

force: clean all

.PHONY: all clean clean-temp force
