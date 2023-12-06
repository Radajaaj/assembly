section .data
    v1: dq  100d
    v2: dq -100d
    v3: dq  0xf121

section .text
    global _start

_start:

fim:
    mov rax, 60
    mov rdi, 0
    syscall