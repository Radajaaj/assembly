section .text
    global _start

_start:
    mov al, 0x81
toshl:
    shl al, 1

toshr:
    shr al, 1
    
fim:
    mov eax, 60
    mov rdi, 0
    syscall