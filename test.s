section        .text   ; contient le code executable
    global         _start
_start:
    mov rax, 60 ; system call : sys_exit (mov to rax as specified by the system call table)
    mov rdi, 1  ; error code return
    syscall


