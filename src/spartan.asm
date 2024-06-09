format ELF64 executable
entry main

; These should be fixed
STDOUT equ 1
STDERR equ 2
EXIT_SUCCESS equ 0
EXIT_FAILURE equ 1
AF_INET equ 2
SOCK_STREAM equ 1
IPPROTO_IP equ 0
INADDR_ANY equ 0

; These can be changed
PORT equ 10506
MAX_CONN equ 10

include 'syscalls.inc'
include 'data.inc'

segment executable
main:
        write STDOUT, init_msg, init_msg.size

        ; Create socket
        write STDOUT, sock_create_msg, sock_create_msg.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        cmp rax, 0
        jl error
        mov qword [sockfd], rax

        ; Bind socket
        write STDOUT, sock_bind_msg, sock_bind_msg.size
        mov word [svraddr.sin_family], AF_INET
        mov word [svraddr.sin_port], PORT
        mov dword [svraddr.sin_addr], INADDR_ANY
        bind [sockfd], svraddr, svraddr.size
        cmp rax, 0
        jl error

        ; Listen for connections
        write STDOUT, sock_listen_msg, sock_listen_msg.size
        listen [sockfd], MAX_CONN
        cmp rax, 0
        jl error
        
        write STDOUT, ok_msg, ok_msg.size

        ; Close socket and exit
        close [sockfd]
        exit EXIT_SUCCESS

error:
        write STDERR, err_msg, err_msg.size  

        ; Close socket and exit
        close [sockfd]
        exit EXIT_FAILURE
