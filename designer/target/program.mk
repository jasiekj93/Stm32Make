# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)

ifneq ($(NAMESPACE),)
program_namespace := $(NAMESPACE)::$(NAME)
else
program_namespace := $(NAME)
endif

define file_cpp
#pragma once

/**
 * @file Main.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

using namespace $(program_namespace);

int main(int argc, char* argv[])
{

	return 0;
}

endef

.PHONY: program $(full_program_name).cpp 

program: $(full_program_name).cpp  $(full_program_makefile)

include BuildRules.mk