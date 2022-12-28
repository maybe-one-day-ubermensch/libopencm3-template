# template project
PROJECT = bluepill-template
BUILD_DIR = build

# libopencm3
OPENCM3_DIR = ./libopencm3
DEVICE = stm32f103c8t6
OPENCM3_TARGETS = stm32/f1

# openocd
OOCD_INTERFACE = stlink
OOCD_TARGET = stm32f1x

# target info
CXXFILES = src/main.cpp
CXXSTD = -std=c++20

elf: $(BUILD_DIR)/$(PROJECT).elf
objcopy: $(BUILD_DIR)/$(PROJECT).bin

default: elf objcopy

build-libopencm3:
	$(MAKE) -C $(OPENCM3_DIR) TARGETS=$(OPENCM3_TARGETS)

include $(OPENCM3_DIR)/mk/genlink-config.mk
include rules.mk
include $(OPENCM3_DIR)/mk/genlink-rules.mk
