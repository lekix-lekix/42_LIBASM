section     .bss
    lst_begin:  resq    1   ; saving beginning of list
    cmp_func:   resq    1   ; saving func ptr
    prev:       resq    1   ; previous elem while iterating

section     .text
    global      ft_list_sort

ft_list_sort:           ; void ft_list_sort(t_list **begin_list, int (*cmp)())
    push    rbp                     ; stack == 8
    mov     rbp, rsp
    cmp     rdi, 0
    je      .error_exit
    cmp     rsi, 0
    je      .error_exit
    cmp     DWORD [rdi], 0
    je      .error_exit
    mov     [rel lst_begin], rdi    ; saving it in stack to be able to get it back 
    mov     [rel cmp_func], rsi     ; saving it in stack to be able to get it back 
    call    .begin_cmp_loop
    pop     rbp
    ret

.error_exit:
    pop     rbp
    ret

.begin_cmp_loop:
    mov     rcx, [rel lst_begin]    ; starting from beginning of list
    mov     rcx, [rcx]              ; dereferencing to get the actual node
    mov     qword [rel prev], 0     ; init prev at null

.cmp_loop:
    cmp     qword [rcx + 8], 0      ; checking null current->next
    je      .ret
    mov     rdi, rcx                ; loading current->data
    mov     rsi, [rcx + 8]          ; loading element->next
    push    rdi                     ; saving just in case (stack = 16)
    push    rsi                     ; stack = 24
    push    rcx                     ; stack = 32
    mov     rdi, [rdi]              ; dereferencing to get direct access to value hold by node->data
    mov     rsi, [rsi]
    call    [rel cmp_func]          ; calling cmp_func on curr->data and next->data
    pop     rcx
    pop     rsi
    pop     rdi
    cmp     eax, 0                  ; if curr->data > next->data : swap needed ; checking eax to get a 32 bits signed int (rax : 64 bits unsigned)
    jg      .swap_elems             ; > 0 = left elem > right elem
    mov     [rel prev], rcx         ; saving prev to be able to modifiy prev->next
    mov     rcx, [rcx + 8]          ; curr = curr->next
    jmp     .cmp_loop

.swap_elems:            ; rdi : current, rsi: current->next
    mov     rbx, [rel prev]         ; loading prev element
    cmp     rbx, 0                  ; is there a prev ?
    je      .set_first_elem         ; no -> we're at list begin and need to set next as first element
    mov     rcx, [rsi + 8]          ; saving next->next
    mov     [rdi + 8], rcx          ; tying the rest of the list to the new last node (AKA current)
    mov     [rsi + 8], rdi          ; setting current as next->next
    mov     [rbx + 8], rsi          ; prev->next = next
    jmp     .begin_cmp_loop         ; starting over

.set_first_elem:        ; rdi : current, rsi: current->next
    mov     rcx, [rsi + 8]          ; saving previous next->next
    mov     [rdi + 8], rcx          ; tying the rest of the list to the new last node (AKA current)
    mov     [rsi + 8], rdi          ; setting current as next->next
    mov     rbx, [rel lst_begin]    ; loading **begin_list
    mov     [rbx], rsi              ; moving next as first elem of list
    jmp     .begin_cmp_loop         ; starting over

.ret:
    ret
    
