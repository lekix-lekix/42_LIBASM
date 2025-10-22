section     .text
    global      ft_strdup
    
extern malloc
extern ft_strlen
extern ft_strcpy

ft_strdup:
    push    rbp                 ; pushing rbp for stack alignment
    mov     rbp, rsp            ; setting stack frame to top
    call    ft_strlen           ; calling ft_strlen with str to copy already in 
    sub     rsp, 8              ; creating space on the stack to hold a local variable
    mov     [rbp - 8], rdi      ; saving the original string ptr passed as arg
    inc     rax                 ; need on more byte for the \0
    mov     rdi, rax            ; moving the result of ft_strlen as arg for malloc
    call    malloc wrt ..plt    ; calling malloc to allocate n bytes 
    cmp     rax, 0              ; checking if the result of malloc is NULL
    je      .end                ; if so, returning it
    mov     rdi, rax            ; moving malloc return ptr as dest for ft_strcpy
    mov     rsi, [rbp - 8]      ; moving original str as src for ft_strcpy
    push    rax                 ; saving rax, as some part of it will be erased by ft_strcpy
    call    ft_strcpy

.end:
    pop     rax                 ; restoring rax 
    add     rsp, 8              ; destroying stack variable
    pop     rbp                 ; restoring base pointer
    ret
