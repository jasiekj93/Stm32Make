# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

#program configuration
SED ?= sed

#paths and names
template_path := ../template

full_namespace := $(NAMESPACE)
ifneq ($(SUBSPACE),)
full_namespace += ::$(SUBSPACE)
endif

path := lib$(subst ::,/,$(full_namespace))
lib_path := $(CWD)/lib$(subst ::,-,$(NAMESPACE))
full_path := $(lib_path)/$(path)

test_path := $(lib_path)/tests
mock_path := $(lib_path)/tests/mock
program_path := $(CWD)/$(NAME)

ifneq ($(SUBSPACE),)
test_path += /$(SUBSPACE)
mock_path += /$(SUBSPACE)
endif

class_name := $(NAME)
full_name := $(full_path)/$(class_name)
full_test_name := $(test_path)/$(class_name)
full_mock_name := $(mock_path)/$(class_name)

full_program_name := $(program_path)/Main
full_program_makefile := $(program_path)/Makefile