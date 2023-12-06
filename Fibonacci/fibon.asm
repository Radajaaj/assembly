;------------------------SEQUENCIA DE FIBONACCI------------------------;

;O n-ésimo número da sequência ficará armazenado em $r12---------------;

;INSTRUNÇÕES DE MONTAGEM:
;   1  - Abra o diretório do arquivo fibon.asm no terminal;------------;
;   2  - execute "sudo apt install nasm";------------------------------;
;   3  - execute "nasm -f elf64 fibon.asm";----------------------------;
;   4  - execute "ld fibon.o -o fibon.x";------------------------------;
;       4.1 - Arquivo montado e linkado!;------------------------------;
;   5  - execute "./fibon.x" para executar o arquivo;------------------;
;DENTRO DO GDB:
;   6  - "gdb fibon.x"-------------------------------------------------;
;   7  - "b fim"-------------------------------------------------------;
;   8  - "r"-----------------------------------------------------------;
;   9  - Insira qualquer numero de 1 a 92------------------------------;
;   10 - Para ler o resultado, "p /d $r12"-----------------------------;


%define maxChars 255

section .data
    msgInsira  : db "Fibonacci requerido (entre 1 e 92): ", 0
    msgInsiraL : equ $ - msgInsira
    msgErro1   : db "Entrada inválida", 10, 0
    msgErro1L  : equ $ - msgErro1
    msgErro2   : db "Execução Encerrada", 10, 0
    msgErro2L  : equ $ - msgErro2
    fileName1  : db "fib("  ;Nome do arquivo output. Será concatenado em fileName
    fileName2  : db ").bin", 0
    zerochar   : db "0"     ;Usado para gerr o nome de arquivos onde o input tem um digito
    fibo       : dq 0       ;Ponteiro para o resultado do calculo

section .bss
    asciiInput : resb maxChars ;User input as string
    intInput   : resq 1     ;User input as integer
    fileName   : resb 12    ;fileName1 + asciiInput + fileName2

section .text
    global _start

_start:

;=--==---==--= Aqui, pedimos pro user inserir um numero =--==---==--=
    mov rax, 1              ;codigo write
    mov rdi, 1              ;write on terminal
    lea rsi, [msgInsira]    ;a mensagem de entrada
    mov edx, msgInsiraL     ;apenas os chars necessarios
    syscall


;=--==---==--= Aqui, recebemos o input do user =--==---==--=
    mov rax, 0
    mov rdi, 1
    lea rsi, [asciiInput]
    mov edx, maxChars
    syscall

    mov r8, rax ;o numero de caracteres inseridos pelo user sera armazenado em r8
    ;No de chars inseridos = Input + 1;; esse 1 é o enter inserido no final


;=--==---==--= Aqui, vamos ver se o no de chars inseridos é == 1, ou >3 =--==---==--=
    cmp r8, 1               ;Se sim, damos o erro
    je erro
    cmp r8, 3
    jg erro



;=-=--=-= Aqui, checamos se os chars inseridos sao numeros (valor entre 0x30 e 0x39) =-=--=-=
    lea rcx, [asciiInput]
    mov al, [rcx]
comparacao: ;loop para comparar todos os caracteres (permite expansão do código)
    cmp al, 0x30
    jl erro
    cmp al, 0x39
    jg erro 
    inc rcx
    mov al, [rcx]
    cmp al, 10
    jne comparacao ;checamos todos os chars, ate chegarmos ao 10 (fim da string)



;=--==---==--= Aqui, criamos o nome do arquivo =--==---==--=
    mov rax, [fileName1]    ;4 digitos
    mov [fileName], rax

    cmp r8b, 3;verificamos se o input tem 1 digito. Se sim, inserimos '0' no nome do arquivo
    je arqFim
    
    mov al, [zerochar]
    mov [fileName + 4], al
    mov al, [asciiInput]
    mov [fileName + 5], al

    jmp arqFim2

arqFim: ;Caso o input tiver 2 digitos, inseriremos o input em si no nome do arquivo
    mov ax, [asciiInput]
    mov [fileName + 4], ax

arqFim2: ;Inserimos a parte final do nome do arquivo
    mov rax, [fileName2]
    mov [fileName + 6], rax ;nome pronto!


    xor rax, rax    ;zeramos rax



;=--==---==--= Aqui, convertemos os chars para um valor int =--==---==--=;

;Todos os códigos e loops abaixo foram feitos pensando numa futura expansão do código
;Ou seja, agora seria fácil expandir o código para que ele possa aceitar qualquer input possível

    ;primeiro, elevamos 10 ao numero de caracteres da string
    mov bx, 10      ;base numerica 10
    mov cx, r8w     ;n de chars
    sub cx, 2       ;gambiarra
    mov ax, 1       ;o reg ax vai ser multiplicado por 10 cx vezes
potencia:
    cmp cx, 0
    jz potenciado        
    mul bx
    dec cx
    jmp potencia
potenciado:
    mov r9w, ax
    ;r9 agora contem 10^(no de chars)

    lea rcx, [asciiInput];ponteiro para a string de inputs do usuario
    mov bl, [rcx]
    mov r10b, 10

conversao: ;loop para converter todos os caracteres de uma string de qualquer tamanho possível
    sub bl, 0x30         ;converter char -> int
    mul bl
    add [intInput], ax
    
    ;checamos se r9 == 1 (condição de saida)
    cmp r9w, 1
    je saidaconversao
     
    ;agora, dividimos r9 por 10
    mov ax, r9w
    div r10b
    mov r9w, ax

    ;movemos para o proximo caractere
    inc rcx
    mov bl, [rcx]
    jmp conversao
saidaconversao: ;Agora, o valor numérico do input está armazenado em intInput!



;=--==---==--= Aqui checamos se intInput está entre 1 e 92 =--==---==--=;
    mov rcx, [intInput]
    cmp rcx, 0
    je erro     ;não vamos levar em consideração o caso de intInput ser menor que 0
                ;também assumimos que não existe um "zerésimo" elemento da sequência
    cmp rcx, 92
    jg erro     ;n > 92 causa overflow
    


;=--==---==--= Aqui calculamos o fibonacci iterativamente =--==---==--=
    mov rax, 1      ;começa em 1
    xor rbx, rbx    ;começa em 0
    xor rdx, rdx
fibonacci:
    cmp rcx, 0
    je saifibo
    dec rcx
    ;rax - elemento atual    ;rbx - elemento anterior
    mov rdx, rax    ;armazena temporariamente o valor atual de n
    add rax, rbx    ;calcula o proximo elemento da sequencia
    mov rbx, rdx    ;armazena o novo estado anterior em rbx
    jmp fibonacci
saifibo:

    ;Agora, o n-ésimo elmento da sequencia de fibonacci está armazenado em rbx!!
    ;era para ele estar em rax, mas num é como se fizesse diferença...

    mov [fibo], rbx



pt1:
;=--==---==--= Aqui inserimos o valor no arquivo =--==---==--=
    mov rax, 2          ;open file
    lea rdi, [fileName]
    mov esi, 101        ;create + write
    mov edx, 644o       ;modo de criação
    syscall

    mov r11, rax    ;Armazenamos o local de escrita do arquivo em r11

    mov rax, 1          ;write file
    mov rdi, r11        ;endereço do arquivo
    lea rsi, fibo       ;n-ésimo elemento da sequência
    mov edx, 8          ;8 bytes? tamanho de r12
    syscall

    mov rax, 3          ;close file
    mov rdi, r11        ;endereço do arquivo
    
    ;Pronto!!!11!1!


    jmp fim
erro:
    mov rax, 1          ;codigo write
    mov rdi, 1          ;write on terminal
    mov rsi, [msgErro1]       ;a mensagem de entrada
    mov edx, msgErro1L  ; apenas os chars necessarios
    syscall

    mov rax, 1          ;codigo write
    mov rdi, 1          ;write on terminal
    lea rsi, [msgErro2] ;a mensagem de entrada
    mov edx, msgErro2L  ; apenas os chars necessarios
    syscall    

fim:
    mov rax, 60
    mov rdi, 0
    syscall