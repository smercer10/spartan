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
IPPROTO_TCP equ 6
TCP_NODELAY equ 1
INADDR_ANY equ 0

; These can be changed
PORT equ 14597 ; Little endian representation (actually 1337)
MAX_CONN equ 10

include 'syscalls.inc'
include 'data.inc'

macro check_return
{
        cmp rax, 0
        jl error
}

macro cleanup
{
        write STDOUT, exit_log, exit_log.size
        close [sockfd]
        close [connfd]
}

segment executable
main:
        write STDOUT, init_log, init_log.size

        ; Create socket
        write STDOUT, socket_log, socket_log.size
        socket AF_INET, SOCK_STREAM, IPPROTO_IP
        check_return
        mov qword [sockfd], rax

        ; Enable TCP_NODELAY
        write STDOUT, setsockopt_log, setsockopt_log.size
        setsockopt [sockfd], IPPROTO_TCP, TCP_NODELAY, opt_enable, opt_enable.size
        check_return

        ; Bind address to socket
        write STDOUT, bind_log, bind_log.size
        mov word [svraddr.sin_family], AF_INET
        mov word [svraddr.sin_port], PORT
        mov dword [svraddr.sin_addr], INADDR_ANY
        bind [sockfd], svraddr, svraddrlen
        check_return

        ; Listen to socket
        write STDOUT, listen_log, listen_log.size
        listen [sockfd], MAX_CONN
        check_return

handle_conn:
        ; Wait for client connection
        write STDOUT, accept_log, accept_log.size
        accept [sockfd], cltaddr, cltaddrlen
        check_return
        mov qword [connfd], rax

        ; Respond to client
        write [connfd], http_response, http_response_size
        write STDOUT, response_log, response_log.size

        ; TODO: add way to jump to shutdown

        jmp handle_conn

shutdown:
        cleanup
        exit EXIT_SUCCESS

error:
        write STDERR, err_log, err_log.size
        cleanup
        exit EXIT_FAILURE
