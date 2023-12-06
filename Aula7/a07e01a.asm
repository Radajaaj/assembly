section .data
    ded  : db "play dead!", 10, 0
    dedL : equ $ - ded

section .text
    global _start

_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [ded]
    mov edx, dedL
    syscall
    jmp _start ;loop