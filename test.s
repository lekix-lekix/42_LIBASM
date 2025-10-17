section        .text   ; contient le code executable
    global         _hello
_hello:
    mov rax, 1  ; system call : sys_write
    mov rdi, 1  ; on stdout 
    mov rsi, msg
    mov rdx, msglen  ;
    syscall
    ret

section .data
    msg: db "Hello toi", 10
    msglen: equ $ - msg