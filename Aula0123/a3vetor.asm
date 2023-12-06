section .data
    vetorInt : dd 42, 1, 2, 3, 4, 96, 6, 7, 8, 9

section .text
    global _start

_start:
    ; ponteiro pra vetorInt
    ; *vetorInt
    ; cuidado: x86_64 contem endereços de 8 bytes

    lea r8, [vetorInt]