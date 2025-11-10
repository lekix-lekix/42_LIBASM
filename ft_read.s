section     .text
    global      ft_read

extern      __errno_location

ft_read:
    push    rbp                                 ; setting a new stack frame
    mov     rbp, rsp                            
    mov     rax, 0                              ; syscall 0 = read
    syscall             
    cmp     rax, 0                              ; checking return value of syscall
    jl      .read_error                         ; < 0 : error
    pop     rbp
    ret

.read_error:
    neg     rax                                 ; inverting syscall return, corresponding to errno error values
    mov     rdi, rax                            ; saving rax in rdi (will get erased by errno location)
    call    __errno_location wrt ..plt          ; calling errno location to get the current ptr of errno
    mov     [rax], rdi                          ; dereferencing to write into errno
    mov     rax, -1                             
    pop     rbp
    ret
