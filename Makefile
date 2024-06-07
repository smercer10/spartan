SRC_DIR := src
BIN_DIR := bin

ENTRY := main

SRC := $(SRC_DIR)/$(ENTRY).asm
BIN := $(BIN_DIR)/$(ENTRY)

CC := fasm

$(BIN): $(SRC) | $(BIN_DIR)
	@ $(CC) $< $@

run: $(BIN)
	@ ./$<

$(BIN_DIR):
	@ mkdir $@

clean:
	@ rm -rf $(BIN_DIR)

.PHONY: run clean
