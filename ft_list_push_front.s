; typedef struct s_list
; {
; 	void			*data;
; 	struct s_list	*next;
; }					t_list;
; so total size 16 bytes : 8 bytes for data & 8 bytes for next (both pointers)

extern malloc

section     .text
    global      ft_list_push_front

; section     .bss
    ; new_node:    resb 1         ; reserving 8 bytes for the future new node ptr

ft_list_push_front:             ; rdi : t_list **begin_list, rsi : void *data
    push    rbp                 ; setting a new stack frame
    mov     rbp, rsp            ; moving rsp to the bottom of the new stack
    push    rdi                 ; saving rdi to call pass data as arg for .alloc_new_node
    mov     rdi, rsi            ; setting arg
    call    .alloc_new_node     
    cmp     rax, 0              ; checking error 
    je      .alloc_error_exit   ;
    pop     rdi                 ; restoring rdi
    ; mov     rdi, [rdi]        ; dereferencing list double ptr to reference the first elem
    mov     rsi, rax            ; setting new node as second arg
    call    .push_node_front    
    pop     rbp                 ;
    ret

.push_node_front:
    cmp     byte [rdi], 0       ; accessing first element of list
    je      .add_node_begin     ; just add the new node
    mov     rcx, [rdi]          ; setting rcx (index) as current element of list (here first)
    jmp     .list_loop          

.list_loop:
    cmp     qword [rcx + 8], 0  ; checking curr->next
    je      .add_node           ; null -> add new node
    mov     rcx, [rcx + 8]      ; else -> curr = current->next
    jmp     .list_loop
    
.add_node:
    mov     qword [rcx + 8], rsi  ; curr->next = new node
    ret

.add_node_begin:
    mov     [rdi], rsi
    ret

.alloc_new_node:                ; rdi : void *data
    push    rdi                 ; saving rdi 
    mov     rdi, 16             ; size needed to hold a new node
    call    malloc wrt ..plt    ; wrt ..plt to call from an external library
    cmp     rax, 0              ; checking null
    je      .alloc_error_exit   
    pop     rdi                 ; restoring rdi 
    mov     [rax], rdi          ; node->data = data (rdi)
    mov     qword [rax + 8], 0  ; node->next = NULL
    ret

 .alloc_error_exit:
    ret

; info registers si rdi
; rsi     0x5555555592a0  93824992252576
; rdi     0x7fffffffddb8  140737488346552

; info registers si rdi
; rsi     0x7fffffffddb8  140737488346552
; rdi     0x7fffffffddb8  140737488346552
