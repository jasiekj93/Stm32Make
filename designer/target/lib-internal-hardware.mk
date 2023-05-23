# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-project)

define test_runner_cpp
#pragma once

/**
 * @file Runner.cpp
 * @author $(AUTHOR)
 * @date $(shell date +%Y-%m-%d)
 */

int main(int argc, char* argv[])
{
	return 0;
}

endef

main_dir := $(CWD)/lib$(PROJECT)-$(NAME)
source_dir := $(main_dir)/lib$(PROJECT)/$(NAME)
test_dir := $(main_dir)/tests

make_file := $(main_dir)/Makefile
test_make_file := $(test_dir)/Makefile
test_runner := $(test_dir)/Runner.cpp

.PHONY: lib-internal-hardware $(make_file) $(test_make_file) $(test_runner)

lib-internal-hardware: $(make_file) $(test_make_file) $(test_runner) | $(main_dir) $(source_dir) $(test_dir)

$(make_file): | $(main_dir)
	@echo "Creating file $@"
	@cp $(template_path)/InternalHardwareLibTmp.mk $@
	@$(SED) -i -e 's/@library_name@/$(NAME)/' $@
	@$(SED) -i -e 's#@library_sources@#lib$(PROJECT)/$(NAME)#' $@

$(test_make_file): | $(test_dir)
	@echo "Creating file $@"
	@cp $(template_path)/InternalHardwareTestLibTmp.mk $@
	@$(SED) -i -e 's/@library_name@/$(NAME)/' $@

$(test_runner): | $(test_dir)
	@echo "Creating file $@"
	@$(file > $@,$(test_runner_cpp))

$(main_dir) $(source_dir) $(test_dir):
	@echo "Creating directory $@"
	@mkdir -p $@