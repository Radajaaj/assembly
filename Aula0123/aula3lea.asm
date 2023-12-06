section .data
    ;int vetorInt[10] = {42, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    vetorInt : dd 42, 1, 2, 3, 4, 5, 6, 7, 8, 9

section .text
    global _start

_start:
    ;agora, r8 eh um ponteiro para vetorInt
    lea r8, [vetorInt]
    ;em x86_64, inteiros tem 4 bytes
pt1:
    ;vamos mover o primeiro elemento de vetorInt pra eax
    ;eax = vetorInt[0]
    mov eax, [vetorInt]

    ;como pegar os outros elementos do vetor?
    ;simples. deslocamos o ponteiro vetorInt em 4 bytes (tamanho de um inteiro)
    lea r9, [vetorInt + 4]  ;r9 apontou para vetorInt[0]
                            ;adicionamos 4 e ele agr aponta pra vetorInt[1]
pt2:

    ;busca do segundo elemento com MOV
    mov ebx, [r9]   ; r9 aponta pra vetorInt[1]

pt3:
    ;podemos indexar esse lea? sim!
        ;formato [base + (indexador * deslocamento)]
        ;ex: &vetorInt[5] == [vetorInt + 5*4]       4 = tamanho de int
    lea r10, [vetorInt + 5*4]
    mov ecx, [r10]
    ;basicamente, r10 aponta pra vetorInt[5], e usamo o mov pra fazer 'ecx = vetorInt[5]'
pt4:
    ;mas a busca ja pode ser feita diretamente com mov...
    mov ecx, [vetorInt + 5*4]

fim:
    mov rax, 60
    mov rdi, 0
    syscall