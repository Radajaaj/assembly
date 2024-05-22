section .data
    msg1 db "Digite um num op num: ", 0

    input_scan1 db "%f %c %f", 0
    input_scan_tam equ $- input_scan1

section .bss
    num1 resd 1
    op resb 1
    num2 resd 1
    
    extern printf
    extern scanf
    extern fopen
    extern fclose
    extern fprintf

section .text
    global main

main:
    push rbp
    mov rbp, rsp

	xor rax, rax
    mov rdi, msg1
    call printf
    
    xor rax, rax
    mov rdi, input_scan1
    mov rsi, num1
    mov rdx, op
    mov rcx, num2
    call scanf
    
    movss xmm0, [num1] ;salva o valor lido
    movss xmm1, [num2]
    mov r8b, [op] ;salva o operador lido

    cmp r8b, "a"
    je funcionName ; a função soma q tu vai criar meu amigo vitor

    cmp r8b, "s"
    je funcionName ;função subtração
    
    cmp r8b, "m"
    je funcionName ;função multiplicação
    
    cmp r8b, "d"
    je functionName ;função divisão

    cmp r8b, "e"
    movss xmm2, [op]
    je functionName ;função exponenciação    
    
    mov rsp, rbp
    pop rbp

fim:
    ret
