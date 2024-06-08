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

constants: constants.c | $(BIN_DIR)
	@ gcc $< -o $(BIN_DIR)/$@
	@ ./$(BIN_DIR)/$@

strace: $(BIN)
	@ strace ./$<

clean:
	@ rm -rf $(BIN_DIR)

.PHONY: run constants strace clean
