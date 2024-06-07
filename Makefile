SRC_DIR := src
BIN_DIR := bin

ENTRY_NAME := spartan

ENTRY := $(SRC_DIR)/$(ENTRY_NAME).asm
INCLUDES := $(wildcard $(SRC_DIR)/*.inc)
BIN := $(BIN_DIR)/$(ENTRY_NAME)

CC := fasm

$(BIN): $(ENTRY) $(INCLUDES) | $(BIN_DIR)
	@ $(CC) $< $@

run: $(BIN)
	@ ./$<

$(BIN_DIR):
	@ mkdir $@

clean:
	@ rm -rf $(BIN_DIR)

.PHONY: run clean
