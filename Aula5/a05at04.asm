section .data
    n : dd 40 ;pode mudar pa qqer numero!!

section .bss
    enessimotrinumero : resd 1

section .text
    global _start

_start:
    mov eax, [n]
    inc eax
    imul eax, [n]

    ;mov ebx, edx
    ;shl rbx, 16
    ;mov ebx, eax
    mov r8d, 2
    idiv r8d
;resultado ficou em eax? r: sim
    mov [enessimotrinumero], eax

fim:
    mov eax, 60
    mov rdi, 69
    syscall