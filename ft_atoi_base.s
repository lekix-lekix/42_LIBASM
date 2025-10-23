extern ft_strlen

section     .bss
    str         resq 1
    base        resq 1
    base_len    resd 1

section     .text
    global      ft_atoi_base

ft_atoi_base:
    push    rbp                 ; saving rbp
    mov     rbp, rsp            ; setting up a new stack frame
    mov     [str], rdi          ; saving rdi (string to convert)
    mov     [base], rsi         ; saving rsi (base)
    mov     rdi, [base]         ; setting base as arg
    call    .check_base

.check_base
    call    ft_strlen           ; getting base len
    mov     [base_len], rax     ; saving base len
    cmp     [base_len], 0
    je      .error_exit
    cmp     [base_len], 1
    je      .error_exit

.error_exit
    mov     rax, 0
    ret
