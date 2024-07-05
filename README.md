# Spartan

Spartan is an ultra-lightweight FASM TCP server that utilises pure Linux syscalls.

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/smercer10/spartan/blob/main/LICENSE)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/smercer10/spartan/build.yml?label=CI)](https://github.com/smercer10/spartan/actions/workflows/build.yml)

## Key Features

- ~1 kb static binary
- Nagle-disabled packet transmission
- Complete error handling and logging via the standard streams

## Usage

To test Spartan, simply run the binary, and then establish a connection to **localhost:1337** using any preferred method. E.g., with netcat:

### Process 1 (Server)

```bash
./spartan
```

### Process 2 (Client)

```bash
nc localhost 1337
```

The server will respond with a small HTTP packet. Since the socket has TCP_NODELAY enabled and responses aren't buffered, connecting via a browser will likely trigger multiple responses due to additional resource requests (e.g., a favicon).

![image](https://github.com/smercer10/spartan/assets/130914459/0dc2f721-b733-409b-b7b0-4e50c4524ca3)

## Build Locally

### Prerequisites

- x64 Linux
- FASM
- Make
- readelf (optional)
- GDB (optional)
- strace (optional)
- GCC (optional)

### Makefile Targets

- Build the executable:

```bash
make
```

- Run the server:

```bash
make run
```

- Debug with the GDB TUI:

```bash
make header
make debug ENTRY=<entry point address from the ELF header>
```

- Monitor system calls:

```bash
make strace
```

- Find relevant syscall option values:

```bash
make constants
```

## Future Plans

- Add a graceful shutdown mechanism
- Add command-line configuration options
- Experiment with multithreading
