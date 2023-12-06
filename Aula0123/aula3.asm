; Aula 03 - Registradores e MOV
; arquivo: a03e03.asm
; objetivo: acesso aos dados dos registradores e transferencias
; nasm -f elf64 a03e03.asm ; ld a03e03.o -o a03e03.x

section .data
    v1: dq 0x1111111122334455 
    ;isso eh um vetor de duas dq, pois uma dq tem 32 bit, e nos inserimos 64
    v2: dq 0x0000000000000000
    v3: dq 0x0000000000000000

section .text
    global _start

_start:

pt1:
    mov al , [v1]
    mov ebx, [v1]
    mov rcx, [v1]

pt2:
    mov [v1], al
    mov [v2], ebx
    mov [v3], rcx

pt3:
    mov al , 0x10
    mov ebx, 0x20202020
    mov rcx, 0x3030303030303030

pt4:
    mov byte  [v1], 0x10
    mov word  [v2], 0x1515
    mov dword [v3], 0x20202020

fim:
    mov rax, 60
    mov rdi, 0
    syscall