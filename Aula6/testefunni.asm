;codigo que pega os 6 elementos de um vetor, soma eles, e escreve na tela

section .data
    vector : dd 23, 44, 12, 32, 11, 110

section .bss
    soma : resd 1

section .text
    global _start

_start:
    mov ecx, 0x0
    lea rbx, [vector]

    add ecx, [rbx]
    add rbx, 4
    add ecx, [rbx]
    add rbx, 4
    add ecx, [rbx]
    add rbx, 4
    add ecx, [rbx]
    add rbx, 4
    add ecx, [rbx]
    add rbx, 4
    add ecx, [rbx]
    mov [soma], ecx

print:

    mov rax, 1
    mov rdi, 1
    mov rsi, [soma]
    mov rdx, 4
    ;num sei como printa um int... mas ele de fato printou o caractere que tava ali

fim:
    mov rax, 60
    mov rdi, 0
    syscall