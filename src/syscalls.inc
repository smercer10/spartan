SYS_WRITE equ 1
SYS_SOCKET equ 41
SYS_BIND equ 49
SYS_EXIT equ 60

macro syscall3 nr, arg0, arg1, arg2
{
        mov rax, nr
        mov rdi, arg0
        mov rsi, arg1
        mov rdx, arg2
        syscall
}

macro write fd, buf, count
{
        syscall3 SYS_WRITE, fd, buf, count
}

macro socket domain, type, protocol
{
        syscall3 SYS_SOCKET, domain, type, protocol
}

macro bind sockfd, sockaddr, sockaddr_size
{
        syscall3 SYS_BIND, sockfd, sockaddr, sockaddr_size
}

macro exit code
{
        mov rax, SYS_EXIT
        mov rdi, code
        syscall
}
