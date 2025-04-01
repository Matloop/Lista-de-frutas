section .data
    msg1 db "Digite um numero: ", 0
    len1 equ $ - msg1

    msg2 db "O dobro do numero é: ", 0
    len2 equ $ - msg2

    buffer resb 10  ; Buffer para entrada do usuário
    newline db 10  ; Quebra de linha

section .bss
    num resb 10

section .text
    global _start

_start:
    ; Exibe mensagem para entrada do número
    mov eax, 4      ; syscall: sys_write
    mov ebx, 1      ; stdout
    mov ecx, msg1   ; Endereço da string
    mov edx, len1   ; Tamanho da string
    int 0x80

    ; Lê número do usuário
    mov eax, 3      ; syscall: sys_read
    mov ebx, 0      ; stdin
    mov ecx, buffer ; Endereço do buffer
    mov edx, 10     ; Tamanho máximo da entrada
    int 0x80

    ; Converte string para número
    mov esi, buffer
    call str_to_int
    mov ebx, eax    ; Armazena número lido em EBX

    ; Multiplica por 2
    shl ebx, 1      ; Multiplicação por 2 (shift left)

    ; Converte número para string
    mov eax, ebx
    call int_to_str
    mov ecx, buffer ; Endereço do resultado convertido
    mov edx, eax    ; Comprimento da string

    ; Exibe mensagem do resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Exibe o número convertido
    mov eax, 4
    mov ebx, 1
    int 0x80

    ; Exibe nova linha
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    ; Finaliza programa
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ---- Função: String para Inteiro ----
str_to_int:
    xor eax, eax  ; Zera EAX
    xor ecx, ecx  ; Zera ECX
    mov ecx, 10   ; Multiplicador (base 10)

.convert_loop:
    movzx edx, byte [esi] ; Obtém o caractere atual
    cmp dl, 10      ; Verifica se é um newline (fim da string)
    je .done
    sub dl, '0'     ; Converte ASCII para número
    imul eax, ecx   ; Multiplica resultado anterior por 10
    add eax, edx    ; Adiciona novo dígito ao número
    inc esi         ; Próximo caractere
    jmp .convert_loop

.done:
    ret

; ---- Função: Inteiro para String ----
int_to_str:
    mov edi, buffer + 9 ; Posição final do buffer
    mov byte [edi], 0   ; Terminador NULL
    dec edi

.convert_loop:
    xor edx, edx
    div ecx           ; Divide EAX por 10, resultado em EAX, resto em EDX
    add dl, '0'       ; Converte para ASCII
    mov [edi], dl     ; Armazena no buffer
    dec edi
    test eax, eax     ; Verifica se ainda há dígitos
    jnz .convert_loop

    lea eax, [edi + 1] ; Retorna ponteiro para string convertida
    ret
