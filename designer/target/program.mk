# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-project)

define file_cpp
/**
 * @file Main.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

using namespace $(PROJECT)::$(NAME);

int main(int argc, char* argv[])
{

	return 0;
}

endef

.PHONY: program $(full_program_name).cpp $(full_program_makefile)

program: $(full_program_name).cpp  $(full_program_makefile)

$(full_program_makefile) : | $(program_path)
	@echo "Creating file $@"
	@cp $(template_path)/ProgramTmp.mk $@
	@$(SED) -i -e 's/@program_name@/$(NAME)/' $@

include BuildRules.mk