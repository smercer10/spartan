SYS_WRITE = 1
SYS_SOCKET = 41
SYS_EXIT = 60

macro write fd, buf, count
{
        mov rax, SYS_WRITE
        mov rdi, fd
        mov rsi, buf
        mov rdx, count
        syscall
}

macro socket domain, type, protocol
{
        mov rax, SYS_SOCKET
        mov rdi, domain
        mov rsi, type
        mov rdx, protocol
        syscall
}

macro exit code
{
        mov rax, SYS_EXIT
        mov rdi, code
        syscall
}
