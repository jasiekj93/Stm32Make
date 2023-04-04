# ------------------------------------------------
# @author Adrian Szczepanski
# @date 16-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

supported_platforms := $(notdir $\
	$(basename $\
		$(wildcard $(make_dir)/platform/*.mk)))

#$(call check-platform)
define check-platform
$(if $(filter $(PLATFORM),$(supported_platforms)),,$\
	$(error ERROR: Platform $(PLATFORM) is not supported! Try $(supported_platforms).))
endef

#$(call check-target)
define check-target
$(if $(target),,$\
	$(error ERROR: Variable 'target' is empty!))
endef

#$(call check-library_name)
define check-library_name
$(if $(library_name),,$\
	$(error ERROR: Variable 'library_name' is empty!))
endef

#$(call check-project_name)
define check-project_name
$(if $(project_name),,$\
	$(error ERROR: Variable 'project_name' is empty!))
endef

#$(call check-tested_library_name)
define check-tested_library_name
$(if $(tested_library_name),,$\
	$(error ERROR: Variable 'tested_library_name' is empty!))
endef

#$(call check-install-platform)
define check-install-platform
$(if $(filter $(PLATFORM),Pc32),,$\
	$(error ERROR: Platform $(PLATFORM) is not supporting installation!))
endef