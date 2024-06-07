format ELF64 executable
entry main

segment readable executable
main:
        mov rax, 0x01 ; write
        mov rdi, 0x01 ; stdout
        mov rsi, msg
        mov rdx, 0x0e ; buffer size
        syscall

        mov rax, 0x3c ; exit
        mov rdi, 0x00 ; error code
        syscall

segment readable writeable
        msg db "Hello, World!", 0x0a
