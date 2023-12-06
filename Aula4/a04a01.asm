; Aula 04 - Dados Nao-Inicializados e Estrutura
; arquivo: a04a01.asm
; Atividade
; nasm -f elf64 a04a01.asm ; ld a04a01.o -o a04a01.x

section .data
    ; vetor largura, altura e profundidade
    dimensoes : dw 50, 65, -75 ;dw = 2 bytes
section .bss
    volume : resq 1

section .text
    global _start

_start:
    ; aluno deve:
        ; mover largura para registrador r8?
        ; mover altura para registrador r9?
        ; mover profundidade para registrador r10?
        ; ter cuidado com os tamanhos dos registradores

    ;lea r11d, [dimensoes + 0*2]
    mov r8w, [dimensoes]
    movsx r8,  r8w

    ;lea r11d, [dimensoes + 1*2]
    mov r9w, [dimensoes + 1*2]
    movsx r9,  r9w

    ;lea r11d, [dimensoes + 2*2]
    mov r10w, [dimensoes + 2*2]
    movsx r10, r10w

    ; código base para o cálculo, não alterar!
        xor dx, dx
        mov ax, r8w
        imul r9w
        ;word * word -> ax
        imul r10w
        ;depois pegou ax, fez ax*r10w, e -> dx:ax
        
        mov cx, dx
        ;dai botu os primeiros 16 bits no final de ecx
        shl ecx, 16
        ;levou eles pro começo
        mov cx, ax
        ;e por fim botou os ultimos 16 bits

        ;resposta == ecx
        
        ; resposta 
        ; volume = dimensoes[0] * dimensoes[1] * dimensoes[2]
        ; ecx = volume

    ; aluno deve:
    ;Nota: ecx tem tamanho diferente de [volume]
    movsx rcx, ecx
    mov [volume], rcx
        ; mover resultado ecx para volume
        ; cuidado com o sinal

    ; coloque seu código aqui!
    ; coloque seu código aqui!

fim:
    mov rax, 60
    mov rdi, 0
    syscall



