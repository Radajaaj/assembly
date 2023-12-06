section .data
    erro : db "this isn't working!", 10
    erroL: equ $ - erro

section .bss
    pid  : resd 1

section .text
    global _start

_start:
    ;primeiro, obtemos o pid (ele é retornado em rax)
    mov rax, 27
    syscall

    ;o pid esta em rax, levemos ele pra rdi
    mov rdi, rax
    ;tambem movemos o codigo de erro pro rsi
    mov rsi, 9
    ;e por fim, o codigo de sys_kill pra rax
    mov rax, 62
    syscall

;escreve a mensagem de erro na tela
    mov eax, 1 ;write
    mov rdi, 1 ;on terminal
    lea rsi, [erro] ;that string
    mov edx, erroL ;and that many chars
    syscall

fim:
    mov eax, 60
    mov rdi, 0
    syscall