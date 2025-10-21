section     .text
    global      ft_write
    extern      __errno_location        ; including errno_location func that returns errno's addr

ft_write:
    push    rbp                         ; saving rbp, since we make a syscall here it is mandatory to restore it to align the stack
    mov     rbp, rsp                    ; setting a new stack frame
    mov     rax, 1                      ; calling sys_write (1), all the arguments are already set
    syscall                             ; -> rdi = fd, rsi = char *buf, rdx = size_t count 
    neg     rax                         ; 
    mov     rdi, rax
    call    __errno_location
    mov     [rax], rdi
    mov     rax, -1
    pop     rbp
    ret