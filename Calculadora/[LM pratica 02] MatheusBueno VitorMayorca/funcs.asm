
section .data
    msg1 db "Digite uma equação: ", 0 ;Chamada pro input do usuario

    input_scan1 db "%f %c %f", 0        ;Usado no scanf
    input_scan_tam equ $- input_scan1

    msDebugOP   db "SAIDA: num1: %f op: %c num2: %f result: %f", 10, 0
    msDebugERRO db "Erro: num1: %f op: %c num2: %f result: %f", 10, 0
    const dd 1.0                        ;Debug

    exeCorreta  db "%lf %c %lf = %lf", 10, 0                            ;Usado no fprintf
    exeIncorreta db "%lf %c %lf = funcionalidade não disponível", 10, 0  ;Usado no fprintf

    nomeArquivo db "output.txt", 0
    modoArquivo db "a", 0
    ptrArquivo  dq 0                    ;Ponteiro para o arquivo

    fopenErro   db "Falha na abertura do arquivo! Verifique as permissoes de execucao.", 10, 0

    pos_inf dd 0x7F800000               ;Infinito positvo. Usado para detectar overflow

section .bss
    num1 resd 1
    op resd 1
    num2 resd 1
    
    extern printf
    extern scanf
    extern fopen
    extern fclose
    extern fprintf

section .text
    global main

main:
;-------------------Stack-frame da funcao main
    push rbp
    mov rbp, rsp

;-------------------Printf da requisicao de input do usuario
	xor rax, rax                
    mov rdi, msg1
    call printf                 ;Movemos a mensagem de boas vindas para rdi, e escrevemos ela na tela
    
;-------------------Scanf do input do usuario
    xor rax, rax                
    mov rdi, input_scan1
    mov rsi, num1
    mov rdx, op
    mov rcx, num2
    call scanf                  ;Zeramos rax, pois nao temos nenhum ponto flutuante como parametro

;-------------------Abrimos o arquivo aonde sera escrito o output
    mov rdi, nomeArquivo
    mov rsi, modoArquivo
    call fopen
    mov [ptrArquivo], rax       ;Ponteiro pro arquivo retorna em rax

    cmp rax, 0
    je falhaArquivo
    mov rax, 0                  ;Zeramos rax, para evitar futuros problemas

;-------------------Movemos as variaveis lidas para nossos registradores
    movss xmm0, [num1]          
    movss xmm1, [num2]          ;Salva os valores lidos. Precisão simples (32 bits)
    mov dil, [op]               ;salva o operador lido    dil é o primeiro byte do rdi

;-------------------Compararamos o operador escolhido pelo usuário, e chamamos a função correspondente
    cmp dil, 'a'
    je callAdd

    cmp dil, 's'
    je callSub
    
    cmp dil, 'm'
    je callMul
    
    cmp dil, 'd'
    je callDiv

    cmp dil, 'e'
    je callExp
    
    mov rax, 1      ;Nenhuma operacao valida detectada. Codigo de erro rax 1
    jmp output


;-------------------Aqui, chamamos as operacoes e comparamos o retorno (rax) em baixo da flag output
callAdd:
    call adicao
    jmp output

callSub:
    call subtracao
    jmp output

callDiv:
    call divisao
    jmp output

callMul:
    call multiplicacao
    jmp output

callExp:
    call exponenciacao
    jmp output


;-------------------Comparamos os valores armazenados em rax.  0 - OK   != 0 - erro
output:
    cmp rax, 0      
    jg notOK
    jmp OK


;-------------------Escrevemos no arquivo os resultados
OK:
    call escrevesolucaoOK
    jmp fim


;-------------------Escrevemos no arquivo a operacao + msg de erro
notOK:
    call escrevesolucaoNOTOK
    jmp fim


;-------------------Printamos mensagem de erro, caso o arquivo não consiga ser aberto
falhaArquivo:
    xor rax, rax
    mov rdi, fopenErro
    call printf

;-------------------Destack-frame + finalizacao da execucao
fim:
    ;---------------Fechamos o arquivo
    mov rdi, [ptrArquivo]
    call fclose
    mov rsp, rbp
    pop rbp

    mov rax, 60
    mov rdi, 0
    syscall

%include "operacoes.asm"