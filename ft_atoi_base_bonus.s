extern ft_strlen

section     .bss
    str:         resq 1  ;
    base:        resq 1  ;   
    base_len:    resd 1  ;

section     .text
    global      ft_atoi_base

ft_atoi_base:   ; int ft_atoi_base(char *str, char *base)
    push    rbp                          ; saving rbp
    mov     rbp, rsp                     ; setting up a new stack frame
    mov     [rel str], rdi               ; saving rdi (string to convert)
    mov     [rel base], rsi              ; saving rsi (base)
    mov     rdi, [rel base]              ; setting base as arg
    call    check_base
    cmp     rax, -1
    je      .exit_error
    pop     rbp
    ret

.exit_error:
    mov     rax, 0
    pop     rbp
    ret

;;;;;;;;;;;;;;;

check_base:
    call    check_len                ; checking len related errors
    cmp     rax, -1
    je      .exit
    call    check_invalid_char       ; checking invalid char (+, -, whitespaces)
    cmp     rax, -1
    je      .exit
    call    check_dup_char           ; checking duplicates characters
    cmp     rax, -1
    je      .exit
    call    convert                  ; start conversion
    ret

.exit:
    ret

;;;;;;;;;;;;;;;

convert:
    push    rbp                     ; setting new stack func frame
    mov     rbp, rsp                ; moving rsp to rbp
    sub     rsp, 16                 ; declaring 2 local var (neg & final nb)
    mov     DWORD [rbp - 8], 0      ; negative nb flag on the stack (DWORD == int)
    mov     DWORD [rbp - 4], 0      ; init final nb on the stack 
    mov     rdi, [rel str]          ; moving address of string to convert 
    mov     rcx, -1
    call    .check_sign
    mov     rsi, [rel base]
    call    .convert_loop   
    cmp     DWORD [rbp - 8], 1
    je      .neg_exit
    mov     rax, [rbp - 4]          ; moving final nb to rax (return convention)
    add     rsp, 8
    mov     rsp, rbp
    pop     rbp
    ret

.check_sign:
    mov     al, [rdi]               ; moving first char to cmp
    cmp     al, '-'                 ; checking minus sign
    je      .set_neg                ; yes -> set neg flag
    cmp     al, '+'                 ; checking plus sign
    je      .inc_rcx                ; yes -> inc rcx
    ret

.set_neg:
    mov     DWORD [rbp - 8], 1
    jmp     .inc_rcx

.inc_rcx:
    inc     rcx
    ret

.find_index:        ; arg1 : haystack, char 2 : needle (char)
    push    rcx                     ; saving rcx
    mov     rcx, -1                 ; init index
    mov     al, dil                 ; loading needle into al
    call    .find_index_loop        ; calling loop
    pop     rcx
    ret

.find_index_loop:
    inc     rcx                     
    cmp     byte [rsi + rcx], 0     ; checking null byte
    je      .exit_idx_error         ; yes -> not found 
    cmp     al, [rsi + rcx]         ; comparing needle with curr char of base
    je      .found_index_exit       ; yes -> returning index
    jmp     .find_index_loop        ; not -> looping

.found_index_exit:
    mov     rax, rcx
    ret

.exit_idx_error:
    mov     rax, -1
    ret

.convert_loop:     ; arg1 : str to convert, arg2 : base
    inc     rcx                     ; inc index
    mov     al, [rdi + rcx]         ; getting current char of string to convert
    cmp     al, 0                   ; checking null byte
    je      .exit
    mov     rsi, [rel base]         ; arg1 for find_index (= haystack)
    push    rdi                     ; saving rdi
    mov     dil, al                 ; arg2 for find_index (= needle)
    call    .find_index             
    pop     rdi                     ; restoring rdi
    cmp     rax, -1                 ; error check, -1 == current char not in base
    je      .exit 
    mov     rdx, rax                ; saving index result  
    mov     eax, [rbp - 4]          ; moving final result to rax, (eax == rax but 0ing all other bits) needed to use MUL
    mov     ebx, [rel base_len]     ; getting base len 
    push    rdx                     ; MUL WILL ERASE RDX FFS
    mul     ebx                     ; final nb * base len
    pop     rdx
    add     eax, edx                ; + index of current char (== its value)
    mov     [rbp - 4], rax          ; saving (current) final result
    jmp     .convert_loop

.exit:
    ret

.neg_exit:
    mov     eax, [rbp - 4]          ; moving final nb to rax (return convention)
    neg     eax
    add     rsp, 8
    mov     rsp, rbp
    pop     rbp
    ret

;;;;;;;;;;;;;;;

check_len:
    call    ft_strlen                ; getting rel base len
    lea     rdx, [rel base_len]
    mov     [rdx], rax               ; saving rel base len
    cmp     byte [rdx], 0            ; is rel base len 0
    je      .error_exit              ; yes -> error
    cmp     byte [rdx], 1            ; is base len 1
    je      .error_exit              ; yes -> error
    ret

.error_exit:
    mov     rax, -1
    ret

;;;;;;;;;;;;;;;

check_invalid_char:
    mov     rcx, -1                  ; initializing index
    mov     rdx, [rel base]          ; moving address of base in rdx
    call    .loop
    ret

.loop:
    inc     rcx                      ; incrementing index
    mov     al, [rdx + rcx]          ; dereferencing string addr and put it inside al (rax low)
    cmp     al, 0                    ; checking end of string
    je      .exit_loop               ; exiting loop
    cmp     al, '+'                  ; comparing + char
    je      .error_exit              ; yes -> exit
    cmp     al, '-'                  ; comparing - char
    je      .error_exit              ; yes -> exit
    call    .check_whitespaces       ; checking whitespaces
    cmp     rax, 1                   ; 1 means yes
    je      .error_exit              ; yes -> exit
    jmp     .loop

.check_whitespaces:
    cmp     al, ' '                  ; whitespaces (9 to 13 + 32); checking 32
    je      .found_space             ; exit 1 subfunction
    cmp     al, 13                   ; checking upperbound
    jle     .lower_bound             ; if <= upperbound, going to check the lower bound
    mov     rax, 0                   ; else -> not a whitespace

.lower_bound:
    cmp     al, 9                    ; checking lower bound
    jge     .found_space             ; if >= lower bound AND <= upperbound -> we found a whitespace
    ret                              ; else returning to .loop (funciton has been called)

.found_space:
    mov     rax, 1                   ; 1 means yes
    ret                              ; returning to .loop

.exit_loop:
    ret 

.error_exit:
    mov     rax, -1                  ; error code 
    ret

;;;;;;;;;;;;;;;

check_dup_char:
    mov     rcx, -1                  ; initializing main index
    mov     rdx, [rel base]          ; loading address of base
    call    .outer_loop
    ret

.outer_loop:
    inc     rcx                      ; incrementing index (i)
    cmp     byte [rdx + rcx], 0      ; checking for null byte
    je      .exit_loop               ; end of string = test passed
    mov     al, [rdx + rcx]          ; loading char to dup check
    mov     rbx, rcx                 ; init index at +1 character for inner loop
    call    .inner_loop              ; CALL here (so the inner loop returns), checking rest of str for duplicate
    cmp     rax, -1                  ; -1 = problem
    je      .error_exit              ; problem = base invalid
    jmp     .outer_loop              ; looping

.inner_loop:
    inc     rbx                      ; incrementing index (j)
    cmp     byte [rdx + rbx], 0      ; checking for null byte
    je      .exit_loop               ; end of string = test passed
    cmp     byte [rdx + rbx], al     ; comparing curr char with the one in al previously set in outer_loop
    je      .error_exit              ; equal -> base invalid
    jmp     .inner_loop              ; looping through the rest of string   

.exit_loop:
    mov     rax, 0
    ret

.error_exit:
    mov     rax, -1
    ret