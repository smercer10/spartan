format ELF64 executable

FD_STDOUT = 1
ERR_SUCCESS = 0

include 'syscall.inc'
include 'data.inc'

segment readable executable
entry $
        write FD_STDOUT, start_msg, start_msg.size
        exit ERR_SUCCESS
