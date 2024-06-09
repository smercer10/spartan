INFO equ "INFO: "
ERR equ "ERROR: "

NL equ 10
CR equ 13

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

        init_log db INFO, "Starting server", NL
        response_log db INFO, "Responded to client", NL
        err_log db ERR, "Something went wrong", NL

        socket_log db INFO, "Creating socket", NL
        bind_log db INFO, "Binding socket", NL
        listen_log db INFO, "Listening to socket", NL
        accept_log db INFO, "Waiting for connections", NL

        http_response db "HTTP/1.1 200 OK", CR, NL, \
                         "Content-Type: text/html", CR, NL, \
                         "Content-Length: 27", CR, NL, \
                         "Connection: close", CR, NL, \
                         CR, NL, \
                         "<h1>Hello from Spartan!<h1>"
        http_response_size = $ - http_response
