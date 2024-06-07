NEWLINE = 10

struc db [data]
{
        common
        . db data
        .size = $ - .
}

segment readable
        start_msg db "Starting web server!", NEWLINE
