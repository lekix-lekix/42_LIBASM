section     .text
    global      ft_list_size

ft_list_size:       ; int ft_list_size(t_list *begin_list)
    push    rbp
    mov     rbp, rsp
    mov     rcx, -1         ; init index

.loop:
    inc     rcx
    cmp     rdi, 0          ; checking for null element
    je      .ret_size       ; yes -> rcx is size
    mov     rdi, [rdi + 8]  ; curr = curr->next
    jmp     .loop

.ret_size:
    mov     rax, rcx        ; loading size into rax for convention
    pop     rbp            
    ret

.ret_null:
    mov     rax, 0
    ret