# ------------------------------------------------
# @author Adrian Szczepanski
# @date 14-02-2024
# ------------------------------------------------

# define solution platforms
# if your platform requires to pass $(sysroot) variable in build process
# write that path after '=' symbol
# e.g. ArmA7-Linux=/home/stm32mp1/sdk/sysroots/cortexa7t2hf-neon-vfpv4-ostl-linux-gnueabi
PLATFORMS := \
Pc32 \

# directories
project_dir := .
make_dir := $(project_dir)/make

include $(make_dir)/Solution.mk