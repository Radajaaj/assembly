section .data
    Nome : db "Vitor Mayorca Camargo", 10
    NomeTamanho : equ $ - Nome

section .text
    global _start

_start:  
    mov rax, 1
    mov rdi, 1
    lea rsi, [Nome]
    mov edx, NomeTamanho
    syscall

     
    ;isso eh uma flag break point111
    ;ele nao pode se chamar de breakpont

    mov rax, 60
    mov rdi, 6
    syscall