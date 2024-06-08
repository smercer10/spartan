format ELF64 executable

FD_STDOUT = 1
ERR_SUCCESS = 0
AF_INET = 2
SOCK_STREAM = 1
IPPROTO_IP = 0

include 'syscalls.inc'
include 'data.inc'

segment readable executable
entry $
        write FD_STDOUT, start_msg, start_msg.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        exit ERR_SUCCESS
