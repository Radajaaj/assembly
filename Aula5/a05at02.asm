section .data
    maiuscula: db 'a' ;A + 32 = a
    minuscula: db 'B' ;b - 32 = B

section .bss
    lowercase: resb 1
    uppercase: resb 1

section .text
    global _start

_start:
    mov al, [maiuscula]
    xor al, 00100000b
    mov [lowercase], al

    mov bl, [minuscula]
    xor bl, 00100000b
    mov [uppercase], bl

    ;só isso?
    ;dica do dia: leia os slides do edmar, eles explicam muito bem

fim:
    mov eax, 60
    mov rdi, 0
    syscall