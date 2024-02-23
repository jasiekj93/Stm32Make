# ------------------------------------------------
# @author Adrian Szczepanski
# @date 21-02-2024
# ------------------------------------------------

# This file is only a template and should be included 
# in other Makefile

# Do not modify this!
SHELL := /bin/bash

#include custom functions
include $(make_dir)/Functions.mk
$(call check-linux_root)
$(call check-sdk_enviroment)
$(call check-kernel_version)

# Directories
current_dir := $(shell pwd)
build_dir := $(current_dir)/build
source_dir_name := linux-$(kernel_version)
source_dir := $(current_dir)/$(source_dir_name)
artifact_dir := $(build_dir)/install_artifact
artifact_boot_dir := $(artifact_dir)/boot
artifact_modules_dir := $(artifact_dir)/lib/modules/$(kernel_version)

config_file := $(build_dir)/.config
uImage_file := $(artifact_boot_dir)/uImage
modules_symbols_file := $(artifact_modules_dir)/modules.symbols

device_tree_target := $(patsubst %.dts,%.dtb,$(notdir $(device_tree_source)))

# targets
.PHONY: init menuconfig build-kernel build-modules build-dtb deploy-kernel deploy-modules deploy-all clean mrproper distclean

init: $(config_file)

menuconfig: $(config_file)
	+@source $(sdk_enviroment) && \
		$(MAKE) -C $(build_dir) ARCH=arm menuconfig

build-kernel: $(uImage_file)

build-modules: $(modules_symbols_file)

build-dtb: $(uImage_file) 
	@echo Building device tree
	+@source $(sdk_enviroment) && \
		$(MAKE) -C $(source_dir) ARCH=arm dtbs $(device_tree_target) LOADADDR=0xC2000040 O="$(build_dir)"
	@echo Copying device tree artifacts to $(artifact_boot_dir)
	@cp $(build_dir)/arch/arm/boot/dts/st*.dtb $(artifact_boot_dir)/

deploy-all: deploy-kernel deploy-modules

deploy-kernel: $(uImage_file)
	$(call check-hostname)
	@echo Deploying kernel and device tree to $(hostname)
	@mv $(artifact_boot_dir)/$(device_tree_target) $(artifact_boot_dir)/device_tree_board_name
	@scp -r $(artifact_boot_dir)/* $(hostname):/boot/

deploy-modules: $(modules_symbols_file)
	$(call check-hostname)
	@echo Deploying modules to $(hostname)
	@rm $(artifact_modules_dir)/source $(artifact_modules_dir)/build
	@scp -r $(artifact_modules_dir)/* root@192.168.7.1:/lib/modules/$(kernel_version)/

$(build_dir) $(artifact_boot_dir):
	@echo Creating directory $@
	@mkdir -p $@

$(source_dir):
	@echo Unpacking directory $(source_dir_name)
	@tar xf $(linux_root)/$(source_dir_name).tar.xz
	@echo Patching directory $(source_dir_name)
	@for p in `ls -1 $(linux_root)/*.patch`; \
		do patch -d $@ -p1 < $$p; \
	done
ifneq ($(device_tree_source),)
	@echo Copying project device tree sources
	@cp $(device_tree_source) $@/arch/arm/boot/dts/
endif

$(config_file): Makefile | $(build_dir) $(source_dir) 
	source $(sdk_enviroment) && \
	$(MAKE) -C $(source_dir) ARCH=arm O="$(build_dir)" multi_v7_defconfig fragment*.config
	for f in `ls -1 $(linux_root)/fragment*.config`; \
		do $(source_dir)/scripts/kconfig/merge_config.sh -m -r -O $(build_dir) $(build_dir)/.config $$f; \
	done
	source $(sdk_enviroment) && \
	(yes '' || true) | $(MAKE) -C $(source_dir) ARCH=arm oldconfig O="$(build_dir)"

$(uImage_file): $(config_file) Makefile | $(artifact_boot_dir) 
	@echo Building kernel
	+@source $(sdk_enviroment) && \
		$(MAKE) -C $(source_dir) ARCH=arm uImage vmlinux dtbs $(device_tree_target) LOADADDR=0xC2000040 O="$(build_dir)"
	@echo Copying kernel artifacts to $(artifact_boot_dir)
	@cp $(build_dir)/arch/arm/boot/uImage $(artifact_boot_dir)/
	@cp $(build_dir)/arch/arm/boot/dts/st*.dtb $(artifact_boot_dir)/

$(modules_symbols_file): $(uImage_file) Makefile
	@echo Building modules
	+@source $(sdk_enviroment) && \
		$(MAKE) -C $(source_dir) ARCH=arm modules O="$(build_dir)"
	@echo Copying modules artifacts to $(artifact_dir)/lib/modules
	+@source $(sdk_enviroment) && \
		$(MAKE) -C $(source_dir) ARCH=arm INSTALL_MOD_PATH="$(artifact_dir)" modules_install O="$(build_dir)"

clean: 
	@echo Cleaning build directory
	@rm -rf $(build_dir)

mrproper: clean 
	@echo Cleaning $(source_dir_name) directory
	@rm -rf $(source_dir) 

distclean: mrproper


