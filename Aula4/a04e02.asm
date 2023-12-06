section .data
    v1: db 0x61
    v2: dd 0x65646362

section .bss
    n1: resb 1
    n2: resd 1
    n3: resb 1

section .text
    global _start

_start:
    mov al, [v1]
    lea r8, [v1]

    lea r9, [v2]
    mov rbx, [v2]
    mov rcx, [r9]

    lea r10, [_start] ; ?
    lea r11, [fim]

fim:
    mov rax, 60
    mov rdi, 0
    syscall