SYS_WRITE equ 1
SYS_CLOSE equ 3
SYS_SOCKET equ 41
SYS_BIND equ 49
SYS_LISTEN equ 50
SYS_EXIT equ 60

macro vararg_syscall nr*, arg0, arg1, arg2
{
        mov rax, nr
        match any, arg0 \{ mov rdi, arg0 \}
        match any, arg1 \{ mov rsi, arg1 \}
        match any, arg2 \{ mov rdx, arg2 \}
        syscall
}

macro write fd*, buf*, count*
{
        vararg_syscall SYS_WRITE, fd, buf, count
}

macro close fd*
{
        vararg_syscall SYS_CLOSE, fd
}

macro socket domain*, type*, protocol*
{
        vararg_syscall SYS_SOCKET, domain, type, protocol
}

macro bind sockfd*, sockaddr*, sockaddr_size*
{
        vararg_syscall SYS_BIND, sockfd, sockaddr, sockaddr_size
}

macro listen sockfd*, backlog*
{
        vararg_syscall SYS_LISTEN, sockfd, backlog
}

macro exit code*
{
        vararg_syscall SYS_EXIT, code
}
