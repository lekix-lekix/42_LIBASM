section     .text
    global      ft_strlen

ft_strlen:
    push    rbp                     ; pushing RBP (base pointer) to the stack. AKA saving its current state
    mov     rbp, rsp                ; setting rbp to rsp (top of stack), setting a new function frame
    mov     rcx, -1                 ; initializing counter to -1

check_loop:
    inc     rcx                     ; incrementing counter (our index here)
    cmp     byte [rdi + rcx], 0x00  ; is character rdi begin + inc (first argument of func) a null ?
    jne     check_loop              ; if no \0 found, restart the function and loop
    mov     rax, rcx                ; move rcx to rax (return register)
    pop     rbp                     ; restoring rbp
    ret                             ; and return it
