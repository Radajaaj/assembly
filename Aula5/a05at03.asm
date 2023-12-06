section .data
    triangularNum : dd 0, 1, 3, 6, 10, 15, 21, 28

section .bss
    somatorio : resd 1

section .text
    global _start

_start:
    lea rax, [triangularNum]

    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]
    inc rax
    inc rax
    inc rax
    inc rax
    add ebx, [rax]

    mov [somatorio], ebx

fim:
    mov rax, 60
    mov rdi, 69
    syscall