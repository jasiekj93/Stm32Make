# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

include Functions.mk
include Configuration.mk

$(call check-name)
$(call check-project)

main_dir := $(CWD)/lib$(PROJECT)-$(NAME)
source_dir := $(main_dir)/lib$(PROJECT)/$(NAME)

make_file := $(main_dir)/Makefile

.PHONY: lib-internal-sofware $(make_file)

lib-internal-sofware: $(make_file) | $(main_dir) $(source_dir)

$(make_file) : | $(main_dir)
	@echo "Creating file $@"
	@cp $(template_path)/InternalSoftwareLibNoTestsTmp.mk $@
	@$(SED) -i -e 's/@library_name@/$(NAME)/' $@
	@$(SED) -i -e 's#@library_sources@#lib$(PROJECT)/$(NAME)#' $@

$(main_dir) $(source_dir): 
	@echo "Creating directory $@"
	@mkdir -p $@