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
        write STDOUT, init_log, init_log.size

        ; Create socket
        write STDOUT, socket_log, socket_log.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        cmp rax, 0
        jl error
        mov qword [sockfd], rax

        ; Bind address to socket
        write STDOUT, bind_log, bind_log.size
        mov word [svraddr.sin_family], AF_INET
        mov word [svraddr.sin_port], PORT
        mov dword [svraddr.sin_addr], INADDR_ANY
        bind [sockfd], svraddr, svraddrlen
        cmp rax, 0
        jl error

        ; Listen to socket
        write STDOUT, listen_log, listen_log.size
        listen [sockfd], MAX_CONN
        cmp rax, 0
        jl error

handle_conn:
        ; Wait for client connection
        write STDOUT, accept_log, accept_log.size
        accept [sockfd], cltaddr, cltaddrlen
        cmp rax, 0
        jl error
        mov qword [connfd], rax

        ; Respond to client
        write [connfd], http_response, http_response_size
        write STDOUT, response_log, response_log.size

        jmp handle_conn

        ; Close everything and exit
        close [sockfd]
        close [connfd]
        exit EXIT_SUCCESS

error:
        write STDERR, err_log, err_log.size

        ; Close everything and exit
        close [sockfd]
        close [connfd]
        exit EXIT_FAILURE
