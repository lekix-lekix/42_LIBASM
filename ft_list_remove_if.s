section     .text
    global      ft_list_remove_if

ft_list_remove_if:      ; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
    push    rbp
    mov     rbp, rsp
    cmp     rdi, 0
    je      .error_exit                     ; checking every argument to check if null
    cmp     rsi, 0
    je      .error_exit
    cmp     rdx, 0
    je      .error_exit
    cmp     rcx, 0
    sub     rsp, 48
    
    mov     [rbp - 40], rdx                 ; saving cmp_func
    mov     [rbp - 32], rsi                 ; saving data_ref
    mov     [rbp - 24], rcx                 ; saving free_fct
    mov     [rbp - 8], rdi                  ; saving begin_list reference

    ; [rbp - 8] = t_list **begin_list
    ; [rbp - 16] = prev node ptr
    ; [rbp - 24] = free_fct ptr
    ; [rbp - 32] = data_ref
    ; [rbp - 40] = cmp_func

    call    .begin_cmp_loop
    add     rsp, 48
    pop     rbp
    ret

.begin_cmp_loop:
    mov     qword [rbp - 16], 0             ; init prev to null
    mov     rcx, [rbp - 8]                  ; init rcx to begin_list
    mov     rcx, [rcx]                      ; dereferencing to get direct node access

.cmp_loop:
    cmp     rcx, 0                          ; checking for null node
    je      .ret                            ; == end of list
    mov     rdi, rcx                        ; current node->data as first arg
    mov     rsi, [rbp - 32]                 ; data_ref as second arg
    push    rcx                             ; saving current node 
    mov     rdi, [rdi]
    ; mov     rsi, [rsi]
    call    [rbp - 40]                      ; calling cmp func
    pop     rcx                             ; restoring current node
    cmp     rax, 0                          ; cmp func == 0 ?
    je      .remove_elem                    ; yes -> elem needs to be removed
    mov     qword [rbp - 16], rcx           ; saving current node as prev
    mov     rcx, [rcx + 8]                  ; current = current->next
    jmp     .cmp_loop

.remove_elem:
    cmp     qword [rbp - 16], 0             ; is prev null ?
    je      .update_lst_begin               ; yes -> elem to remove is begin of list and thus the begin needs to be updated with to_remove->next
    cmp     qword [rcx + 8], 0              ; checking to_remove->next
    je      .update_lst_end                 ; yes -> prev needs to be updated to end of lst (NULL)
    ; mov     rdi, rcx                        ; to_remove as first arg
    ; call    .free_node
    ; jmp     .begin_cmp_loop

.free_node:
    push    rcx                             ; saving rcx (node)
    mov     rcx, [rcx]                      ; getting access to node->data
    call    [rbp - 24]                      ; free node->data
    pop     rcx
    call    [rbp - 24]                      ; free node
    jmp     .begin_cmp_loop

.update_lst_begin:
    mov     rdi, [rbp - 8]                  ; getting **begin_list
    mov     rsi, [rcx + 8]                  ; getting to_remove->next
    mov     [rdi], rsi                      ; *begin_list = to_remove->next     
    jmp     .free_node

.update_lst_end:
    mov     rdi, [rbp - 16]                 ; getting prev node
    mov     qword [rdi + 8], 0              ; prev->next = NULL
    jmp     .free_node

.error_exit:
    mov     rax, -1
    ret     

.ret:
    ret