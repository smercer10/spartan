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
        servaddr sockaddr_in

        start_msg db INFO, "Starting web server!", NL
        sock_create_msg db INFO, "Creating socket...", NL
        sock_bind_msg db INFO, "Binding socket...", NL
        done_msg db INFO, "Done.", NL
        err_msg db ERR, "Something went wrong.", NL
