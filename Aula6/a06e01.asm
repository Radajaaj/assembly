;FUNÇÃO: Ler um input do usuario, e soltar ele na tela

%define maxChars 20
;Depois dessa tinha, todo texto "maxChars" sera substituido pelo valor 10

section .data
    strOla  : db "Hello?", 10, 0
    strOlaL : equ $ - strOla

    strBye  : db "Voce disse ", 0
    strByeL : equ $ - strBye

    strLF   : db 10 ;quebra de linha ACII
    strLFL  : db 1

section .bss
    strLido : resb maxChars
    strLidoL: resd 1

section .text
    global _start

_start:
    mov rdi, 1 ; vamos sempre usar os caminhospadrão de entrada e saida de dados
    ;mov rax 0-read 1-write
    ;lea rsi - endereço do começo da string, na memoria
    ;mov edx - tamanho da string

    ;primeiro vamos printar a pergunta
    mov rax, 1
    lea rsi, [strOla]
    mov edx, strOlaL
    syscall ;e executamos
pt1:
    ;recebemos a resposta, e armazenamos em strLido
    mov rax, 0
    lea rsi, [strLido]
    mov edx, maxChars
    syscall
;ele leu! e agora, em rax, ele retornou o numero de caracteres lidos
;pegamos esse numero e armazenamos ele em strLidoL (usamos rad pq strLidoL tem 32 bits (int))
    mov [strLidoL], eax


pt2:
    ;ptintamos o começo da resposta
    mov rax, 1
    lea rsi, [strBye]
    mov edx, strByeL
    syscall
pt3:
    mov rax, 1  ;IMPORTANTE: O retorno da função sempre é armazenado em rax
                ;       logo, é necessário mover o valor da chamada para ele de novo
    ;printamos o input do usuario
    lea rsi, [strLido]
    mov edx, strLidoL ;esse valor tinha retornado de rax la em cima
    syscall

fim:
    mov rax, 60
    mov rdi, 0
    syscall