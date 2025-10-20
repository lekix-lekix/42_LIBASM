section     .text
    global      ft_strcmp

ft_strcmp:
    push    rbp                              ; saving rbp
    mov     rbp, rsp                         ; setting a new function stack frame
    mov     rcx, -1                          ; initializing an index to -1

.loop:              
    add     rcx, 1                           ; incrementing index
    cmp     byte [rdi + rcx], 0x00           ; checking if null byte at arg + index
    je      .return_diff                     ; jumping if null byte found
    mov     al, [rdi + rcx]                  ; moving second char in the low part of rax (al), cant use two dereference in one instruction
    cmp     al, [rsi + rcx]             ; comparing the two args at arg + index
    jne     .return_diff
    je      .loop

.return_diff:
    ; mov     al, [rdi + rcx]               ; moving value of first char to rax (return register)
    sub     al, [rsi + rcx]                 ; substracting value of second char, according to glibc
    pop     rbp
    ret     