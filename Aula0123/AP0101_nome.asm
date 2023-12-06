section .data
    Nome : db "Vitor Mayorca Camargo", 10
    NomeTamanho : equ $ - Nome

section .text
    global _start
    mov rax, 60
    mov rdi, 1
    syscall

_start:
    mov rax, 1
    mov rdi, 1
    lea rsi, [Nome]
    mov edx, NomeTamanho
    syscall

    mov rax, 60
    mov rdi, 2
    syscall