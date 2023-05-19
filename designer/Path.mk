# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

path := lib$(subst ::,/,$(NAMESPACE))
lib_path := lib$(subst ::,-,$(NAMESPACE))
full_path := $(CWD)/$(lib_path)/$(path)
full_name := $(full_path)/$(NAME)

test_path := $(CWD)/$(lib_path)/tests
full_test_name := $(test_path)/$(NAME)