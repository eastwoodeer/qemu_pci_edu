MODULE_NAME        := edu_pci
MODULE_LICENSE     := GPL
MODULE_VERSION     := 0.1
MODULE_AUTHOR      := chenbin
MODULE_DESCRIPTION := Qemu PCI edu device driver

ifneq ($(KERNELRELEASE),)
obj-m			:= $(MODULE_NAME).o

name-fix   = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
ccflags-y += -DCONFIG_MODULE_AUTHOR=$(call name-fix,$(MODULE_AUTHOR))
ccflags-y += -DCONFIG_MODULE_VERSION=$(call name-fix,$(MODULE_VERSION))
ccflags-y += -DCONFIG_MODULE_DESCRIPTION=$(call name-fix,$(MODULE_DESCRIPTION))
ccflags-y += -DCONFIG_MODULE_LICENSE=$(call name-fix,$(MODULE_LICENSE))
else
PWD			:= $(shell pwd)
# KERNEL_HEAD		:= $(shell uname -r)
# KERNEL_DIR		:= /lib/modules/$(KERNEL_HEAD)/build
KERNEL_DIR := ~/Data/github.com/linux
CROSS_COMPILE := ~/Projects/toolchains/arm-gnu-toolchain-12.2.rel1-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-
ARCH := arm64

all:
	ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) $(MAKE) -C $(KERNEL_DIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(PWD) clean

install:
	sudo insmod $(MODULE_NAME).ko

remove:
	sudo rmmod $(MODULE_NAME)

endif
