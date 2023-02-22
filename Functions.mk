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