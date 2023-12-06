section .data
    v1: db 0x61
    v2: dd 0x65646362

section .bss
    n1: resb 1 ;1 byte   logo, printamos com "p /x (char) n1"
    n2: resd 1 ;4 bytes  logo, printamos com "p /x (int) n2"
    n3: resb 1 ;1 byte

section .text
    global _start

_start:
    mov al   , [v1]
    mov [n1] , al
    mov [n3] , al
    mov ebx  , [v2]
    mov [n2] , ebx

fim:
    mov rax, 60
    mov rdi, 0
    syscall