#
#	BitThunder OS
#

#
#	If we are building a fully fledged OS, then include the real memory manager.
#
include $(BASE)os/.config.mk

BT_OS_OBJECTS-$(BT_CONFIG_OS) += $(BUILD_DIR)os/src/bt_main.o
BT_OS_OBJECTS-$(BT_CONFIG_OS) += $(BUILD_DIR)os/src/mm/bt_mm.o
BT_OS_OBJECTS-$(BT_CONFIG_OS) += $(BUILD_DIR)os/src/mm/bt_heap.o
BT_OS_OBJECTS-$(BT_CONFIG_OS) += $(BUILD_DIR)os/src/devman/bt_devman.o

include $(BASE)os/src/interfaces/objects.mk


include $(BASE)arch/$(ARCH)/objects.mk
include $(BASE)arch/$(ARCH)/mach/$(SUBARCH)/.config.mk
include $(BASE)arch/$(ARCH)/mach/$(SUBARCH)/objects.mk
#SUB_OBJDIRS += $(BASE)arch/$(ARCH)/mach/$(SUBARCH)/
#SUB_OBJDIRS += $(BASE)arch/$(ARCH)/

test2:
	echo $(BT_CONFIG_KERNEL)
ifeq ($(BT_CONFIG_KERNEL), FreeRTOS)
$(BUILD_DIR)os/src/mm/bt_heap.o: CFLAGS += -DBT_CONFIG_KERNEL_FREERTOS
$(BUILD_DIR)os/src/mm/bt_mm.o: CFLAGS += -DBT_CONFIG_KERNEL_FREERTOS
endif


BT_OS_OBJECTS += $(BT_OS_OBJECTS-y)
$(BT_OS_OBJECTS): MODULE_NAME="BitThunder"

OBJECTS += $(BT_OS_OBJECTS)
