section     .text
    global      ft_read

extern      __errno_location

ft_read:
    push    rbp
    mov     rbp, rsp
    mov     rax, 0
    syscall
    cmp     rax, 0
    jle     .read_error
    pop     rbp
    ret

.read_error:
    neg     rax
    mov     rdi, rax
    call    __errno_location wrt ..plt
    mov     [rax], rdi
    mov     rax, -1
    pop     rbp
    ret
