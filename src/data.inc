INFO equ "INFO: "
ERR equ "ERROR: "

NL equ 10

struc db [data]
{
        common
        . db data
        .size = $ - .
}

segment readable writeable
        start_msg db INFO, "Starting web server!", NL
        sock_create_msg db INFO, "Creating socket...", NL
        done_msg db INFO, "Done.", NL
        err_msg db ERR, "Something went wrong.", NL

        sockfd dq 0
