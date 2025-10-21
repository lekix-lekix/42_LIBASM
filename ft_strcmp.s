section     .text
    global      ft_strcmp

ft_strcmp:
    push    rbp                              ; saving rbp
    mov     rbp, rsp                         ; setting a new function stack frame
    mov     rcx, -1                          ; initializing an index to -1

.loop:              
    add     rcx, 1                           ; incrementing index
    movzx   rax, byte [rdi + rcx]            ; moving current char of first arg to rax and zeroing the rest of the register
    movzx   rdx, byte [rsi + rcx]            ; moving current char of second arg to rax and zeroing the rest of the register
    cmp     byte [rax + rcx], 0x00           ; checking if null byte at arg + index
    je      .return_diff                     ; jumping if null byte found
    cmp     rax, rdx                         ; comparing the two args at arg + index
    jne     .return_diff                     ; jumping if a difference is found 
    je      .loop

.return_diff:
    sub     rax, rdx                        ; returning the difference between the two strings 
    pop     rbp                             ; restoring rbp
    ret


; if rax / rdx is not zeroed, returning or subbing make strange things happen
; because only a char is is stored in a 8 byte register