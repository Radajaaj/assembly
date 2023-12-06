section .data
    v1: db  100d
    v2: db -100d

section .text
    global _start

_start:

    mov   al, [v2]
    
    movzx r8, al
    movsx r9, al

    mov   r10, qword 0xffffffffffffffff
    movzx r10, al

    mov   r11, qword 0xffffffffffffffff
    movsx r11, al


fim:
    mov rax, 60
    mov rdi, 0
    syscall