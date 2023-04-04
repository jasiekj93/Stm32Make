# ------------------------------------------------
# @author Adrian Szczepanski
# @date 28-03-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Append Configuration variables from file here
include $(make_dir)/Configuration.mk

# directoires
text_dir := $(docs_dir)/text
html_dir := $(docs_dir)/html
pdf_dir := $(docs_dir)/pdf

# source files and targets
text_targets := $(addprefix $(text_dir)/,$(notdir $(programs:.1=.1.txt)))
text_targets += $(addprefix $(text_dir)/,$(notdir $(libraries:.3=.3.txt)))

html_targets := $(addprefix $(html_dir)/,$(notdir $(programs:.1=.1.html)))
html_targets += $(addprefix $(html_dir)/,$(notdir $(libraries:.3=.3.html)))

pdf_targets := $(addprefix $(pdf_dir)/,$(notdir $(programs:.1=.1.pdf)))
pdf_targets += $(addprefix $(pdf_dir)/,$(notdir $(libraries:.3=.3.pdf)))

vpath %.1 $(sort $(dir $(programs)))
vpath %.3 $(sort $(dir $(libraries)))

#targets
.PHONY: all clean text html pdf

all: text html pdf
text: $(text_targets)
html: $(html_targets)
pdf: $(pdf_targets)
print-%: ; @echo "$* = $($*)"

#build rules 
$(text_dir)/%.1.txt: %.1 Makefile | $(text_dir)
	@echo Building $@
	@man -Tutf8 $< > $@

$(text_dir)/%.3.txt: %.3 Makefile | $(text_dir)
	@echo Building $@
	@man -Tutf8 $< > $@

$(pdf_dir)/%.1.pdf: %.1 Makefile | $(pdf_dir)
	@echo Building $@
	@man -Tpdf $< > $@

$(pdf_dir)/%.3.pdf: %.3 Makefile | $(pdf_dir)
	@echo Building $@
	@man -Tpdf $< > $@

$(html_dir)/%.1.html: %.1 Makefile | $(html_dir)
	@echo Building $@
	@man -Thtml $< > $@

$(html_dir)/%.3.html: %.3 Makefile | $(html_dir)
	@echo Building $@
	@man -Thtml $< > $@

$(text_dir) $(pdf_dir) $(html_dir):
	@echo Creating directory $@
	@$(MKDIR) $@	

clean:
	@echo Cleaning man pages
	-@$(RMDIR) $(text_dir) $(html_dir) $(pdf_dir)