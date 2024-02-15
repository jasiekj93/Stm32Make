# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)

define git_ignore_file
build
bin
lib
test
endef

external_dir := $(CWD)/external

make_file := $(CWD)/Makefile
project_file := $(CWD)/Project.mk
git_ignore := $(CWD)/.gitignore

.PHONY: init-solution $(make_file) $(project_file) $(git_ignore) 

init-solution: $(make_file) $(project_file) $(git_ignore) | $(external_dir)
	git -C $(CWD) submodule add https://github.com/jasiekj93/cpputest external/CppUTest

$(make_file): 
	@echo "Creating file $@"
	@cp $(template_path)/SolutionTmp.mk $@

$(project_file): 
	@echo "Creating file $@"
	@cp $(template_path)/MainTmp.mk $@
	@$(SED) -i -e 's/@project_name@/$(NAME)/' $@

$(git_ignore): 
	@echo "Creating file $@"
	@$(file > $@,$(git_ignore_file))

$(external_dir):
	@echo "Creating directory $@"
	@mkdir -p $@