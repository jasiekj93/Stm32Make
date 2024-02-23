# ------------------------------------------------
# @author Adrian Szczepanski
# @date 21-02-2024
# ------------------------------------------------

# Directories
project_dir ?= ..
make_dir := $(project_dir)/make

linux_root := 
sdk_enviroment := 

hostname := 
kernel_version := 6.1.28

device_tree_source := 

device_tree_board_name := stm32mp157d-dk1.dtb

# Append rest of Makefile from template
include $(make_dir)/Linux.mk