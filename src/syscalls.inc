SYS_WRITE equ 1
SYS_CLOSE equ 3
SYS_SOCKET equ 41
SYS_ACCEPT equ 43
SYS_BIND equ 49
SYS_LISTEN equ 50
SYS_SETSOCKOPT equ 54
SYS_EXIT equ 60

macro vararg_syscall nr*, arg0, arg1, arg2, arg3, arg4
{
        mov rax, nr
        match any, arg0 \{ mov rdi, arg0 \}
        match any, arg1 \{ mov rsi, arg1 \}
        match any, arg2 \{ mov rdx, arg2 \}
        match any, arg3 \{ mov r10, arg3 \}
        match any, arg4 \{ mov r8, arg4 \}
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

macro accept sockfd*, addr*, addrlen*
{
        vararg_syscall SYS_ACCEPT, sockfd, addr, addrlen
}

macro bind sockfd*, addr*, addrlen*
{
        vararg_syscall SYS_BIND, sockfd, addr, addrlen
}

macro listen sockfd*, backlog*
{
        vararg_syscall SYS_LISTEN, sockfd, backlog
}

macro setsockopt socket*, level*, option_name*, option_value*, option_len*
{
        vararg_syscall SYS_SETSOCKOPT, socket, level, option_name, option_value, option_len
}

macro exit status*
{
        vararg_syscall SYS_EXIT, status
}
