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
targets := \
class \
interface \
interface-impl \
interface-single \
interface-single-impl \
mock-interface \
mock-interface-single \
program \
lib-internal-software \
lib-internal-software-no-tests \
lib-internal-hardware \
lib-internal-hardware-no-tests \
lib-software \
lib-hardware \
init-project \

.PHONY: $(targets)

default:
	$(error No target was selected to create!)		

$(targets):
	+@$(MAKE) --file=target/$@.mk