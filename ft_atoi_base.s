extern ft_strlen

section     .bss
    str:         resq 1  ;
    base:        resq 1  ;   
    base_len:    resd 1  ;

section     .text
    global      ft_atoi_base

ft_atoi_base:
    push    rbp                          ; saving rbp
    mov     rbp, rsp                     ; setting up a new stack frame
    mov     [rel str], rdi               ; saving rdi (string to convert)
    mov     [rel base], rsi              ; saving rsi (base)
    mov     rdi, [rel base]              ; setting base as arg
    call    check_base
    cmp     rax, -1
    je      .exit_error
    mov     rax, 1
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
    ; call    check_dup_char           ; checking duplicates characters
    ; cmp     rax, 0
    ; je      .exit
    ret

.exit:
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
    call    .loop
    ret

.loop:
    inc     rcx                      ; incrementing index
    mov     rdx, [rel base]          ; moving address of base in rdx
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
    mov     rcx, -1                  ; initializing index
    call    .outer_loop

.outer_loop:
    inc     rcx                      ; incrementing index (i)
    mov     rdx, [rel base]          ; loading address of base
    cmp     byte [rdx + rcx], 0
    ; cmp     byte [rel base + rcx], 0 ; checking for null byte
    je      .exit_loop               ; end of string = test passed
    mov     dil, [rdx + rcx]    ; loading char to dup check
    mov     rbx, -1                  ; init index for inner loop
    call    .inner_loop              ; checking rest of str for duplicate
    call    .outer_loop              ; going through each char to check dup

.inner_loop:
    inc     rbx                      ; incrementing index (j)
    lea     rdx, [rel base]
    cmp     byte [rdx + rbx], 0     ; checking for null byte
    je      .exit_loop               ; end of string = test passed
    cmp     byte [rdx + rbx], dil   ; comparing curr char with the one in rdi 
    je      .error_exit               ; equal -> base invalid
    call    .inner_loop              ; looping through the rest of string   

.exit_loop:
    ret

.error_exit:
    mov     rax, 0
    ret

; error_exit:
;     mov     rax, 0
;     ret
