INFO equ "INFO: "
ERR equ "ERROR: "

NL equ 10

struc sockaddr_in
{
        .sin_family dw 0
        .sin_port dw 0
        .sin_addr dd 0
        .sin_zero dq 0
}

struc db [data]
{
        common
        . db data
        .size = $ - .
}

segment readable writeable
        sockfd dq -1
        connfd dq -1

        svraddr sockaddr_in
        svraddrlen = $ - svraddr ; Readable value
        
        cltaddr sockaddr_in
        cltaddrlen dd 0 ; Writeable address

        init_msg db INFO, "Starting server", NL
        ok_msg db INFO, "Everything was ok", NL
        err_msg db ERR, "Something went wrong", NL

        socket_msg db INFO, "Creating socket", NL
        bind_msg db INFO, "Binding socket", NL
        listen_msg db INFO, "Marking socket as passive", NL
        accept_msg db INFO, "Waiting for connection", NL
