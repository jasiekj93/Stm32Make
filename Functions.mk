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
	$(error ERROR: Platform $(PLATFORM) is not supported! Try '$(supported_platforms)'))
endef

supported_builds := debug release

#$(call check-build)
define check-build
$(if $(filter $(BUILD),$(supported_builds)),,$\
	$(error ERROR: Build $(BUILD) is not supported! Try '$(supported_builds)'))
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

#$(call check-ldscript)
define check-ldscript
$(if $(ldscript),,$\
	$(error ERROR: Variable 'ldscript' is empty!))
endef

#$(call check-REMOTE)
define check-REMOTE
$(if $(REMOTE),,$\
	$(error ERROR: Variable 'REMOTE' is empty!))
endef

#$(call check-linux_root)
define check-linux_root
$(if $(linux_root),,$\
	$(error ERROR: Variable 'linux_root' is empty!))
endef

#$(call check-sdk_enviroment)
define check-sdk_enviroment
$(if $(sdk_enviroment),,$\
	$(error ERROR: Variable 'sdk_enviroment' is empty!))
endef

#$(call check-kernel_version)
define check-kernel_version
$(if $(kernel_version),,$\
	$(error ERROR: Variable 'kernel_version' is empty!))
endef

#$(call check-hostname)
define check-hostname
$(if $(hostname),,$\
	$(error ERROR: Variable 'hostname' is empty!))
endef

#$(call check-destination_device_tree_name)
define check-destination_device_tree_name
$(if $(destination_device_tree_name),,$\
	$(error ERROR: Variable 'destination_device_tree_name' is empty!))
endef