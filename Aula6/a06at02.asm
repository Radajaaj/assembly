%define maxChars 255

section .data
    ;arquivo : db "amogus.txt", 0 ;termina com null!
    texto1   : db "Insira o nome do arquivo", 10, 0
    texto1L  : equ $ - texto1
    texto2   : db "Insira o conteudo a ser escrito no arquivo", 10, 0
    texto2L  : equ $ - texto2
    texto3   : db "Está escrito: ", 0
    texto3L  : equ $ - texto3
    arquivo2 : db "papagali.txt", 0
    ;arquivo2L : equ $ - texto3

section .bss
    userText  : resb maxChars
    userTextL : resd 1
    arquivo   : resb maxChars
    arquivoL  : resd 1
    fileHandle: resd 1

section .text
    global _start

_start:
    ;primeiro, pedimos pro usuario inserir o nome do arquivo
    mov rax, 1
    mov rdi, 1 ;saida pawdrao (terminal)
    lea rsi, [texto1]
    mov edx, texto1L
    syscall

    ;Agora, ele vai poder inseri-lo:
    mov rax, 0
    mov rdi, 1 ;entrada padrao (terminal)
    lea rsi, [arquivo]
    mov edx, maxChars
    syscall

    ;O retorno foi o numero de caracteres lidos. Guardaremos este valor
    mov [arquivoL], eax

    ;Agora, pedimos pro usuario inserir o que ele quer escrever no final do arquivo
    mov rax, 1
    mov rdi, 1; terminal
    lea rsi, [texto2]
    mov edx, texto2L
    syscall

    ;E aqui ele vai inserir o texto
    mov rax, 0
    mov rdi, 1 ;terminal
    lea rsi, [userText]
    mov edx, maxChars
    syscall

    dec rax
    mov [userTextL], rax ;armazenamos o n de chars escrevidos (é o retorno de read)
pt1:

;;;;;;;;;;;;;;;;;;;;;;;;;;;Hora do arquivio;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Vamos primeiro abrir o arquivo
    mov rax, 2
    
    lea rdi, [arquivo2] ;lea rdi, [arquivo]
    ;em vez de especificar o endereço do terminal, inserimos o endereço do arquivo
    mov esi, 2102o  ;flags 0-r 1-w 2-rw 100-create 2000-append
                    ;criamos o arquiv (se n existir) e escrevemos no final
    mov edx, 644o ;modo de criação do arquivo
    syscall

    ;arquivo aberto! agora pegamos o seu endereço e botamos em fileHandle
    mov [fileHandle], rax

    ;hora de escrever o input do usuario no fim do arquivo
    mov rax, 1              ;write
    mov rdi, [fileHandle]   ;onde? no arquivo
    lea rsi, [userText]     ;o que? o input do user
    mov edx, [userTextL]     ;quantos chars? o necessario
    syscall



    ;Agora, lemos o que esta escrito no começo do arquivo
    mov rax, 0            ;lemos
    mov rdi, [fileHandle] ;no arquivo
    lea rsi, [userText]   ;e escrevemos em userText
    mov edx, maxChars   ;tudo
    syscall

    ;mov [userTextL], rax ;a funcao retornou o n de caracteres lidos

    ;por fim, printamos o conteudo do arquivo no terminal
    mov rax, 1
    mov rdi, 1
    lea rsi, [userText]
    mov edx, maxChars
    syscall

    ;Para finalizar, fechamos o arquivo!
    mov rax, 3
    mov rdi, [fileHandle]
    syscall

    mov rdi, rax
    
fim:
    mov eax, 60
    mov rdi, 0
    syscall