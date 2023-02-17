# ------------------------------------------------
# @author Adrian Szczepanski
# @date 16-02-2023
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

#target := $(call set-target-name,$(target))
define set-target-name
$(if $(filter $(PLATFORM),Pc32 ArmA9),$\
	$1$(PLATFORM),$\
	$1)
endef

#$(call check-platform)
define check-platform
$(if $(filter $(PLATFORM),Pc32 ArmA9 ArmM7 ArmM4),,$\
	$(error ERROR: Platform $(PLATFORM) is not supported!))
endef