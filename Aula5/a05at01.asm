section .data
    maiuscula: db 'A' ;A + 32 = a
    minuscula: db 'b' ;b - 32 = B

section .bss
    lowercase: resb 1
    uppercase: resb 1

section .text
    global _start

_start:
    mov al, [maiuscula]
    add al, 32d
    mov [lowercase], al

    mov bl, [minuscula]
    sub bl, 32
    mov [uppercase], bl

    ;só isso?
    ;dica do dia: leia os slides do edmar, eles explicam muito bem

fim:
    mov eax, 60
    mov rdi, 0
    syscall