section     .text
    global      ft_strcpy

ft_strcpy:
    push    rbp                             ; saving rbp 
    mov     rbp, rsp                        ; setting the begin of a new stack frame
    mov     rcx, -1                         ; initializing our index

.copy_loop:
    inc     rcx                             ; incrementing index
    cmp     byte [rsi + rcx], 0x00          ; checking for null byte
    je      .quit                           ; yes == its the end of dest -> quit routine
    mov     al, [rsi + rcx]                 ; moving current character of s2 to a temp register
    mov     [rdi + rcx], al                 ; then copying it to src at current index
    jmp     .copy_loop                      ; looping

.quit:
    mov     [rdi + rcx + 1], byte 0x00      ; adding a \0 to the end of dest
    pop     rbp                             ; restoring rbp
    ret
