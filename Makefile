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
OOCD_GDB_LOG = /dev/null

# target info
CXXFILES = src/main.cpp
CXXSTD = -std=c++20

elf: $(BUILD_DIR)/$(PROJECT).elf
objcopy: $(BUILD_DIR)/$(PROJECT).bin

default: elf objcopy

build-libopencm3:
	$(MAKE) -C $(OPENCM3_DIR) TARGETS=$(OPENCM3_TARGETS)

gdb: elf
	arm-none-eabi-gdb $(BUILD_DIR)/$(PROJECT).elf \
		-ex 'target extended-remote |\
			openocd -f interface/$(OOCD_INTERFACE).cfg\
					-f target/$(OOCD_TARGET).cfg\
					-c "gdb_port pipe; log_output $(OOCD_GDB_LOG)"'\
		-ex 'monitor reset halt'\
		-ex 'load'\
		-ex 'b main'\
		-ex 'continue'

include $(OPENCM3_DIR)/mk/genlink-config.mk
include rules.mk
include $(OPENCM3_DIR)/mk/genlink-rules.mk
