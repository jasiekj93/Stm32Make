# ------------------------------------------------
# @author Adrian Szczepanski
# @date 28-03-2023
# ------------------------------------------------

# Directories
project_dir ?= ..
make_dir := $(project_dir)/make
source_dir := source

# source files 
programs := $(wildcard $(source_dir)/*.1)
libraries := $(wildcard $(source_dir)/*.3)

# Append rest of Makefile from template
include $(make_dir)/ManPages.mk