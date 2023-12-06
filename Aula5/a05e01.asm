section .text
    global _start
;somar 10, 20, 30 e -2
_start:
    mov eax, 10
    mov ebx, 20
    mov ecx, 30
    mov edx, -2

    add eax, ebx
    add edx, ecx
    add eax, edx
;sub tudo
pt1:
    mov eax, 10
    mov ebx, 20
    mov ecx, 30
    mov edx, -2

    sub eax, ebx
    sub ecx, edx
    sub eax, ecx

fim:
    mov eax, 60
    mov rdi, 0
    syscall