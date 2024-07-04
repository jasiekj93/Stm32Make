# ------------------------------------------------
# @author Adrian Szczepanski
# @date 15-02-2024
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Append main make targets(goals) from file here
include $(make_dir)/MainGoals.mk 

# Measuring time feature
# start_time variable is expanded immiediate at the beggining of make process,
# the others are expanded (and executed) during every usage 
# (in this case at the end of build process).
sol_start_time := $(shell date +%s)
sol_end_time = $(shell date +%s)
sol_build_time = $(shell expr $(sol_end_time) - $(sol_start_time) )

# change destination platform if is specified in command line or passed from
# overriding project
ifneq ($(PLATFORM),)
PLATFORMS := $(PLATFORM)
endif

# pass every target(goal) to the project makefile for every platform
# if platform has defined sysroot, separate it to different variables
$(make_goals):
	@$(foreach platform,$(PLATFORMS),\
		echo "Executing '$@' target for platform $(firstword $(subst =, sysroot=,$(platform)))";\
		$(MAKE) -f Project.mk PLATFORM=$(subst =, sysroot=,$(platform)) $@;)
	@echo "Solution building time: [$(sol_build_time) seconds]"

print-%  : ; @echo "$* = $($*)"