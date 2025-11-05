extern malloc

section     .text
    global      ft_list_push_front

ft_list_push_front:             ; rdi : t_list **begin_list, rsi : void *data
    push    rbp                 ; setting a new stack frame (stack -= 8 == -8)
    mov     rbp, rsp            ; moving rsp to the bottom of the new stack
    push    rdi                 ; saving rdi to pass data as arg for .alloc_new_node (stack -= 8 == -16)
    mov     rdi, rsi            ; setting arg
    call    .alloc_new_node     
    cmp     rax, 0              ; checking error 
    je      .alloc_error_exit   ;
    pop     rdi                 ; restoring rdi
    mov     rsi, rax            ; setting new node as second arg
    call    .push_node_front    
    pop     rbp                 ;
    ret

.push_node_front:
    cmp     qword [rdi], 0       ; accessing first element of list
    je      .add_node_begin      ; just add the new node
    mov     rcx, [rdi]           ; getting first node 
    mov     qword [rsi + 8], rcx ; new_node -> next = first node
    mov     [rdi], rsi           ; *begin_list = new_node
    ret

.add_node_begin:
    mov     [rdi], rsi
    ret

.alloc_new_node:                ; rdi : void *data
    push    rdi                 ; saving rdi (stack -= 8 == -24 !)
    sub     rsp, 8              ; aligning stack (misaligned because of push rdi)
    mov     rdi, 16             ; size needed to hold a new node
    call    malloc wrt ..plt    ; wrt ..plt to call from an external library
    cmp     rax, 0              ; checking null
    add     rsp, 8             
    je      .alloc_error_exit   
    pop     rdi                 ; restoring rdi 
    mov     [rax], rdi          ; node->data = data (rdi)
    mov     qword [rax + 8], 0  ; node->next = NULL
    ret

 .alloc_error_exit:
    ret
