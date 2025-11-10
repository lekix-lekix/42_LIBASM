section     .text
    global      ft_strcmp

ft_strcmp:
    push    rbp                              ; saving rbp
    mov     rbp, rsp                         ; setting a new function stack frame
    mov     rcx, -1                          ; initializing an index to -1

.loop:              
    inc     rcx                              ; incrementing index
    mov     al, [rdi + rcx]                  ; moving s1 + i to al (rax low register)
    mov     dl, [rsi + rcx]                  ; moving s2 + i to al (rdx low register)
    cmp     al, 0                            ; s1 + i == NULL ?
    je      .return_diff                     
    cmp     al, dl                           ; s1 + i != s2 + i ? 
    jne     .return_diff
    jmp     .loop

.return_diff:
    movzx   eax, al                          ; moving char to eax, we're going to sub dl from al, but we need to put it to a signed register to get a neg nb
    movzx   edx, dl                          ; movzx to zero the rest of the register 
    sub     eax, edx                         ; returning the difference between the two strings 
    pop     rbp                              ; restoring rbp
    ret
