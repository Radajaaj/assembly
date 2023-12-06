section .data
    v1: dq 0x61
    v2: dq 97d
    v3: dq 141o
    v4: dq 1100001b

section .text
    global _start

_start:
    ; gdb x / [bhwg][cduxto] &<nomeVar>

fim:
    mov rax, 60
    mov rdi, 0
    syscall