.MODEL SMALL
.STACK

.DATA
    ; Definir las cadenas terminadas en '$'
    cadenas DB "Murcielago$", "Hola$", "TASM$", "Ensambladoraaaaa$", "Vocales$"
    num_cadenas EQU 5        ; Total de cadenas
    max_vocales DB 0         ; M?ximo de vocales encontradas
    max_indice DW 0          ; ?ndice de la cadena con m?s vocales (ahora es un word de 16 bits)
    vocales_cadenas DB 5 DUP(0)  ; Tabla para almacenar las vocales de cada cadena
    mensaje1 DB 10, 13, "La cadena con m?s vocales es: $"
    mensaje2 DB 10, 13, "Tiene un total de vocales: $"

.CODE

principal PROC FAR
    ; Inicializar segmentos
    MOV AX, SEG @data
    MOV DS, AX  

    ; Inicializar contadores
    XOR BX, BX                ; BX = ?ndice de la cadena actual
    MOV max_vocales, 0        ; Inicializar m?ximo de vocales
    MOV max_indice, 0         ; Inicializar ?ndice del m?ximo

procesar_cadenas:
    ; Calcular la direcci?n de la cadena actual
    MOV SI, OFFSET cadenas    ; Direcci?n base de las cadenas
    MOV CX, BX                ; Guardar el ?ndice actual en CX
    SHL CX, 1                 ; Multiplicar por 2 (tama?o de cada cadena con '$')
    ADD SI, CX                ; Avanzar al inicio de la cadena actual

    ; Contar vocales en la cadena
    XOR DL, DL                ; Reiniciar el contador de vocales
contar_vocales:
    LODSB                     ; Cargar el car?cter actual en AL
    CMP AL, '$'               ; Comprobar si es el fin de la cadena
    JE evaluar_max

    ; Verificar si el car?cter es una vocal
    CMP AL, 'a'
    JE incrementar_contador
    CMP AL, 'e'
    JE incrementar_contador
    CMP AL, 'i'
    JE incrementar_contador
    CMP AL, 'o'
    JE incrementar_contador
    CMP AL, 'u'
    JE incrementar_contador
    CMP AL, 'A'
    JE incrementar_contador
    CMP AL, 'E'
    JE incrementar_contador
    CMP AL, 'I'
    JE incrementar_contador
    CMP AL, 'O'
    JE incrementar_contador
    CMP AL, 'U'
    JE incrementar_contador
    JMP contar_vocales

incrementar_contador:
    INC DL                    ; Incrementar el contador de vocales
    JMP contar_vocales

evaluar_max:
    MOV vocales_cadenas[BX], DL  ; Guardar el n?mero de vocales de la cadena actual
    CMP DL, max_vocales       ; Comparar el conteo actual con el m?ximo
    JBE siguiente_cadena      ; Si no es mayor, continuar con la siguiente cadena
    MOV max_vocales, DL       ; Actualizar m?ximo de vocales
    MOV AX, BX                ; Mover el ?ndice de la cadena (16 bits)
    MOV max_indice, AX        ; Actualizar el ?ndice de la cadena

siguiente_cadena:
    INC BX                    ; Incrementar ?ndice de la cadena
    CMP BX, num_cadenas
    JL procesar_cadenas       ; Si no hemos terminado, procesar la siguiente cadena

mostrar_resultado:
    ; Mostrar mensaje de la cadena con m?s vocales
    LEA DX, mensaje1
    MOV AH, 09h
    INT 21h

    ; Mostrar la cadena con m?s vocales
    MOV SI, OFFSET cadenas
    MOV AX, max_indice        ; Cargar el ?ndice de la cadena con m?s vocales (16 bits)
    SHL AX, 1                 ; Multiplicar por 2 (tama?o de cada cadena con '$')
    ADD SI, AX                ; Avanzar a la cadena correspondiente
    MOV DX, SI                ; Pasar la direcci?n a DX
    MOV AH, 09h
    INT 21h

    ; Mostrar el mensaje del total de vocales
    LEA DX, mensaje2
    MOV AH, 09h
    INT 21h

    ; Mostrar el n?mero de vocales (max_vocales)
    MOV AL, max_vocales
    ADD AL, '0'               ; Convertir el n?mero a ASCII
    MOV DL, AL
    MOV AH, 02h
    INT 21h

salir:
    MOV AX, 4C00h
    INT 21h

principal ENDP
END principal