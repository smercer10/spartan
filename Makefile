SRC_DIR := src
BIN_DIR := bin

EXEC_NAME := spartan

EXEC_SRC := $(SRC_DIR)/$(EXEC_NAME).asm
INCLUDES := $(wildcard $(SRC_DIR)/*.inc)

EXEC := $(BIN_DIR)/$(EXEC_NAME)

ENTRY ?=

$(EXEC): $(EXEC_SRC) $(INCLUDES) | $(BIN_DIR)
	@ fasm $< $@

run: $(EXEC)
	@ ./$<

strace: $(EXEC)
	@ strace ./$<

# Run as: make debug ENTRY=(entry point address from ELF header)
debug: $(EXEC)
	@ gdb -tui -ex "b *$(ENTRY)" ./$<

constants: constants.c | $(BIN_DIR)
	@ gcc $< -o $(BIN_DIR)/$@
	@ ./$(BIN_DIR)/$@

header: $(EXEC)
	@ readelf -h ./$<

$(BIN_DIR):
	@ mkdir $@

clean:
	@ rm -rf $(BIN_DIR)

.PHONY: run strace debug constants header clean
