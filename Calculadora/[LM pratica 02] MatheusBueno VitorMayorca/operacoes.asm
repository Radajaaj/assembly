;float adicao()
;float subtracao()
;float multiplicacao()
;float divisao()
;float exponenciacao        (float op1, float op2)
;void escrevesolucaoOK      (float op1, char op, float op2, float resposta, int ponteiroArquivo)
;void escrevesolucaoNOTOK   (float op1, char op, float op2, float ponteiroArquivo)
;char getOperador           (char op)

;-------------------------------- Função de SOMA -------------------------------;
adicao:                 ;Funcao de adicao
    push rbp
    mov  rbp, rsp       ;Stack-Frame

    mov byte [op], "+"       ;Mudamos op para o simbolo do operadr

    movss xmm2, xmm0    ;O processador nao deixou fazer vaddss xmm2, xmm1, xmm0

    addss xmm2, xmm1    ;Soma 2 por 1, armazena em 2
    addeado:

    ucomiss xmm2, [pos_inf] ;Checamos se houve overflow, ao comparar com o infinito
    je overflow
    jp overflow

    mov rax, 0          ;Funcao retorna 0 se deu tudo certo

    jmp saidaOp  
;-------------------------------------------------------------------------------;


;----------------------------- Função de SUBTRAÇÃO -----------------------------;
subtracao:
    push rbp
    mov  rbp, rsp       ;Stack-Frame

    mov byte [op], "-"       ;Mudamos op para o simbolo do operadr

    movss xmm2, xmm0    ;O processador nao deixou fazer vsubss xmm2, xmm1, xmm0

    subss xmm2, xmm1    ;Subtrai 2 por 1, armazena em 2
    
    subeado:
    ucomiss xmm2, [pos_inf] ;Checamos se houve overflow, ao comparar com o infinito
    je overflow
    jp overflow

    mov rax, 0          ;Funcao retorna 0 se deu tudo certo

    jmp saidaOp  
;-------------------------------------------------------------------------------;


;--------------------------- Função de MULTIPLICAÇÃO ---------------------------;
multiplicacao:
    push rbp
    mov  rbp, rsp       ;Stack-Frame

    mov byte [op], "*"       ;Mudamos op para o simbolo do operadr

    movss xmm2, xmm0    ;O processador nao deixou fazer vmulss xmm2, xmm1, xmm0

    mulss xmm2, xmm1    ;Multiplica 2 por 1, armazena em 2
    
    muleado:
    ucomiss xmm2, [pos_inf] ;Checamos se houve overflow, ao comparar com o infinito
    je overflow
    jp overflow

    mov rax, 0          ;Funcao retorna 0 se deu tudo certo

    jmp saidaOp  
;-------------------------------------------------------------------------------;


;------------------------------ Função de DIVISÃO ------------------------------;
divisao:
    push rbp
    mov  rbp, rsp       ;Stack-Frame

    mov byte [op], "/"       ;Mudamos op para o simbolo do operadr

    movss xmm2, xmm0    ;O processador nao deixou fazer vdivss xmm2, xmm1, xmm0

    divss xmm2, xmm1    ;Divide 2 por 1, armazena em 2
    
    dividido:
    ucomiss xmm2, [pos_inf] ;Checamos se houve overflow, ao comparar com o infinito
    je overflow
    jp overflow

    mov rax, 0          ;Funcao retorna 0 se deu tudo certo

    jmp saidaOp  
;-------------------------------------------------------------------------------;


;--------------------------- Função de EXPONENCIAÇÃO ---------------------------;
exponenciacao:
    push rbp
    mov  rbp, rsp       ;Stack-Frame
    
    movss xmm3, xmm0    ;Armazenamos o valor incial de xmm0 em xmm3
    cvttss2si rcx, xmm1  ;primeiro, convertemos xmm1 para inteiro.

    cmp rcx, 0
    jl overflowExp         ;Depois checamos se rcx é negativo (erro)

    movss xmm1, xmm0    ;xmm1 vai armazenar constantemente o numero que está sendo exponenciado
    movss xmm0, [const] ;Dai botamos 1 no xmm0 pra começar o loop
    
    mov rbx, rcx        ;Guardamos o valor original de rcx

    ;For (rcx = op2; rcx > 0; rcx --);  No loop, vamos ir multiplicando xmm0 por xmm1. Daí o retorno vai ficar sendo aumentado no xmm1
    expLoop:
        cmp rcx, 0
        jle exitExpLoop     ;Loop para se rcx chegar a 0

        ;xmm0 - resultado   xmm1 - constante    rcx - numero de vezes a ser multiplicado
        call multiplicacao  ;Multiplica xmm1 por xmm0. Armazena em xmm2
        movss xmm0, xmm2    ;Dai botamos o resultado dessa iteração em xmm0

        dec rcx             ;rcx--
        cmp rax, 0
        je expLoop          ;Se não deu overflow, continuamos o loop

        jmp exitExpLoop        ;Se deu overflow, codigo de erro

        jmp expLoop
    exitExpLoop:

    movss xmm2, xmm0        ;Armazenamos o resultado em xmm2
    cvtsi2ss xmm1, rbx      ;Armazenamos o expoente em xmm1
    movss xmm0, xmm3        ;E o exponenciado em xmm0

    mov byte [op], "^"       ;Mudamos op para o simbolo do operadr

    cmp rax, 0              ;Checamos se deu erro no loop
    je saidaOp              ;Se nao, tudo certo
    jmp overflow            ;Se sim, erro
;-------------------------------------------------------------------------------;


;------------------------------- Flags auxiliares ------------------------------;
overflowExp:
    mov byte [op], "^"       ;Mudamos op para o simbolo do operadr
overflow:
    mov rax, 1
    jmp saidaOp

saidaOp:    ;Destack-frame genérico para todas as funções
    mov rsp, rbp        ;Desalocamos variáveis locais
    pop rbp             ;Recuoeramos ebp antigo + endereço de retorno
    ret                 ;Retorno   
;-------------------------------------------------------------------------------;


;-------------------------------Função EscreveOK -------------------------------;
escrevesolucaoOK:
    push rbp
    mov  rbp, rsp       ;Stack-Frame

;   -------------------printf de debug
    ;mov rax, 3          ;Vamos passar 3 valores em pf
    ;mov rsi, rdi        ;Aqui tava o operador. Vamos mover ele pra rsi
    ;mov rdi, msDebugOP  ;E no rdi vai ficar a mensagem
    ;call printf

;   -------------------Preparamos o fprintf
	mov rax, 2
	mov rdi, [ptrArquivo]
	mov rsi, exeCorreta

	mov rdx, [op]

	cvtss2sd xmm0, xmm0
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm2, xmm2
    call fprintf

    mov rsp, rbp        ;Desalocamos variáveis locais
    pop rbp             ;Recuoeramos ebp antigo + endereço de retorno
    ret                 ;Retorno
;-------------------------------------------------------------------------------;


;----------------------------- Função EscreveNotOK -----------------------------;
escrevesolucaoNOTOK:
    push rbp
    mov  rbp, rsp       ;Stack-Frame
    
;   -------------------printf de debug
    ;mov rax, 3          ;Vamos passar 3 valores em pf
    ;mov rsi, rdi        ;Aqui tava o operador. Vamos mover ele pra rsi
    ;mov rdi, msDebugERRO  ;E no rdi vai ficar a mensagem
    ;call printf

;   -------------------Preparamos o fprintf
	mov rax, 2
	mov rdi, [ptrArquivo]
	mov rsi, exeIncorreta

	mov rdx, [op]

	cvtss2sd xmm0, xmm0
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm2, xmm2
    call fprintf


    mov rsp, rbp        ;Desalocamos variáveis locais
    pop rbp             ;Recuoeramos ebp antigo + endereço de retorno
    ret    
;-------------------------------------------------------------------------------;