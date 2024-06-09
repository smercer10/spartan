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
PORT equ 14597 ; Little endian representation (actually 1337)
MAX_CONN equ 10

include 'syscalls.inc'
include 'data.inc'

segment executable
main:
        write STDOUT, init_msg, init_msg.size

        ; Create socket
        write STDOUT, socket_msg, socket_msg.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        cmp rax, 0
        jl error
        mov qword [sockfd], rax

        ; Bind address to socket
        write STDOUT, bind_msg, bind_msg.size
        mov word [svraddr.sin_family], AF_INET
        mov word [svraddr.sin_port], PORT
        mov dword [svraddr.sin_addr], INADDR_ANY
        bind [sockfd], svraddr, svraddrlen
        cmp rax, 0
        jl error

        ; Mark socket as passive
        write STDOUT, listen_msg, listen_msg.size
        listen [sockfd], MAX_CONN
        cmp rax, 0
        jl error

        ; Wait for client connection
        write STDOUT, accept_msg, accept_msg.size
        accept [sockfd], cltaddr, cltaddrlen
        cmp rax, 0
        jl error
        mov qword [connfd], rax

        write STDOUT, ok_msg, ok_msg.size

        ; Close everything and exit
        close [sockfd]
        close [connfd]
        exit EXIT_SUCCESS

error:
        write STDERR, err_msg, err_msg.size  

        ; Close everything and exit
        close [sockfd]
        close [connfd]
        exit EXIT_FAILURE
