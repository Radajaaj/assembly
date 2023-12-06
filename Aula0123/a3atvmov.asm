;codigo que realize todas as 15 formas de movimentacao de dados

section .data  
    pt1r8  : db 0x10                ;parte 1
    pt1r16 : dw 0x2020
    pt1r32 : dd 0x30303030
    pt1r64 : d1 0x4040404040404040

    pt2m8  : db 0x00                ;parte 2
    pt2m16 : dw 0x0000
    pt2m32 : dd 0x00000000
    pt2m64 : dq 0x0000000000000000

    ;parte 3 nao contem variaveis

    pt4m8  : db 0x00                ;parte 4
    pt4m16 : dw 0x0000
    pt4m32 : dd 0x00000000