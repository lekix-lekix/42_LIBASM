section     .text
    global      ft_write
    extern      __errno_location        ; including errno_location func that returns errno's addr

ft_write:
    push    rbp                         ; saving rbp, since we make a syscall here it is mandatory to restore it to align the stack
    mov     rbp, rsp                    ; setting a new stack frame
    mov     rax, 1                      ; calling sys_write (1), all the arguments are already set
    syscall                             ; -> rdi = fd, rsi = char *buf, rdx = size_t count
    cmp     rax, 0                      ; did sys_write returned an error code ?
    jl      .syscall_error              ; yes -> handle it
    pop     rbp                         ; pop rbp to align the stack
    ret

.syscall_error:
    neg     rax                         ; if error, sys_write will return a negative number, which correspond to the errno errors when inverted
    mov     rdi, rax                    ; saving it to call __errno_location
    call    __errno_location            ; returns the errno address into rax
    mov     [rax], rdi                  ; setting errno at the right error code
    mov     rax, -1                     ; libc write returns -1 in case of error
    pop     rbp                         ; pop rbp to align the stack
    ret
