INFO equ "INFO: "
ERR equ "ERROR: "

NL equ 10

struc db [data]
{
        common
        . db data
        .size = $ - .
}

struc sockaddr_in
{
        .sin_family dw 0
        .sin_port dw 0
        .sin_addr dd 0
        .sin_zero dq 0
        .size = $ - .sin_family
}

segment readable writeable
        sockfd dq 0
        svraddr sockaddr_in
        cltaddr sockaddr_in

        init_msg db INFO, "Starting server!", NL
        ok_msg db INFO, "Everything was ok!", NL
        err_msg db ERR, "Something went wrong!", NL

        sock_create_msg db INFO, "Creating socket...", NL
        sock_bind_msg db INFO, "Binding socket...", NL
        sock_listen_msg db INFO, "Listening for connections...", NL
