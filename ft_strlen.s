section     .text
    global      ft_strlen

ft_strlen:
    push    rbp             ; pushing RBP (base pointer) to the stack. AKA saving its current state
    push    rcx             ; rcx being a save-callee, we save it on the stack 
    mov     rcx, -1         ; initializing counter to -1

check_loop:
    inc     rcx             ; incrementing counter (our index here)
    add     rdi, rcx        ; adding our index to the current address of our argument ( == str + i )
    cmp     byte [rdi], 0x00; is first character of rdi (first argument of func) a null
    jne     check_loop      ; if no \0 found, restart the function and loop
    add     rcx, 1          ; if found, add 1 to get the length and not index
    mov     rax, rcx        ; move rcx to rax (return register)
    ret                     ; and return it




