# ------------------------------------------------
# @author Adrian Szczepanski
# @date 20-12-2024
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-project)

.PHONY: touchgfx-program $(full_program_makefile)

touchgfx-program: $(full_program_makefile)

$(full_program_makefile) : | $(program_path)
	@echo "Creating file $@"
	@cp $(template_path)/TouchGfxProgramTmp.mk $@

include BuildRules.mk