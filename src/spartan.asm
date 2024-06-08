format ELF64 executable
entry main

FD_STDOUT equ 1
FD_STDERR equ 2

AF_INET equ 2
SOCK_STREAM equ 1
IPPROTO_IP equ 0
PORT equ 10506
INADDR_ANY equ 0

EXIT_SUCCESS equ 0
EXIT_FAILURE equ 1

include 'syscalls.inc'
include 'data.inc'

segment executable
main:
        write FD_STDOUT, start_msg, start_msg.size

        ; Create socket
        write FD_STDOUT, sock_create_msg, sock_create_msg.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        cmp rax, 0
        jl error
        mov qword [sockfd], rax
        write FD_STDOUT, done_msg, done_msg.size

        ; Bind socket
        write FD_STDOUT, sock_bind_msg, sock_bind_msg.size
        mov word [servaddr.sin_family], AF_INET
        mov word [servaddr.sin_port], PORT
        mov dword [servaddr.sin_addr], INADDR_ANY
        bind [sockfd], servaddr, servaddr.size
        cmp rax, 0
        jl error
        write FD_STDOUT, done_msg, done_msg.size

        exit EXIT_SUCCESS

error:
        write FD_STDERR, err_msg, err_msg.size

        exit EXIT_FAILURE
