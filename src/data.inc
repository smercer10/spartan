INFO equ "INFO: "
ERR equ "ERROR: "
NL equ 10
CR equ 13

struc db [data]
{
        common
        . db data
        .size = $ - .
}

struc dq [data]
{
        common
        . dq data
        .size = $ - .
}

struc sockaddr_in
{
        .sin_family dw 0
        .sin_port dw 0
        .sin_addr dd 0
        .sin_zero dq 0
}

segment readable writeable
        ; Invalid initially so another valid FD isn't accidentally closed if we exit early
        sockfd dq -1
        connfd dq -1

        opt_enable dq 1

        svraddr sockaddr_in
        svraddrlen = $ - svraddr
        
        cltaddr sockaddr_in
        cltaddrlen dq 0

        init_log db INFO, "Starting server", NL
        socket_log db INFO, "Creating socket", NL
        setsockopt_log db INFO, "Enabling TCP_NODELAY", NL
        bind_log db INFO, "Binding socket", NL
        listen_log db INFO, "Listening to socket", NL
        accept_log db INFO, "Waiting for connections", NL
        response_log db INFO, "Client served", NL
        exit_log db INFO, "Exiting gracefully", NL
        err_log db ERR, "Something went wrong", NL

        http_response db "HTTP/1.1 200 OK", CR, NL, \
                         "Content-Type: text/html", CR, NL, \
                         "Content-Length: 34", CR, NL, \
                         "Connection: close", CR, NL, \
                         CR, NL, \
                         "<h1>Blazingly fast response :)<h1>"
        http_response_size = $ - http_response
