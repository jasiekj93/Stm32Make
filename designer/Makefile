# ------------------------------------------------
# @author Adrian Szczepanski
# @date 06-03-2023
# ------------------------------------------------

# Configurable variables
export CWD ?= ../..
export PLATFORM ?= ArmM7
export AUTHOR ?= Adrian Szczepanski

export NAME
export PROJECT
export NAMESPACE
export SUBSPACE

# internal variables
make_repository := https://github.com/jasiekj93/Stm32Make

# targets
targets := $(notdir $\
	$(basename $\
		$(wildcard target/*.mk)))

.PHONY: $(targets)

default:
	$(error No target was selected to create!)		

$(targets):
	+@$(MAKE) --file=target/$@.mk