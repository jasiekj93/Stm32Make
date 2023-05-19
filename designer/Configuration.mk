# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

full_namespace := $(NAMESPACE)::$(SUBSPACE)

path := lib$(subst ::,/,$(full_namespace))
lib_path := lib$(subst ::,-,$(NAMESPACE))
full_path := $(CWD)/$(lib_path)/$(path)

test_path := $(CWD)/$(lib_path)/tests/$(SUBSPACE)
mock_path := $(CWD)/$(lib_path)/tests/mock/$(SUBSPACE)

class_name := $(NAME)
full_name := $(full_path)/$(class_name)
full_test_name := $(test_path)/$(class_name)
full_mock_name := $(mock_path)/$(class_name)