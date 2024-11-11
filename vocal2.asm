.MODEL SMALL
.STACK 
.DATA
    PROMPT DB 'Ingrese una cadena: $'
    MSG_RESULT DB 'La cadena con mas vocales es: $'
    NL DB 13, 10, '$'

    CADENAS DB 5 DUP(30 DUP(?))  ; Espacio para 5 cadenas de hasta 30 caracteres
    MAX_VOCALES DB 0             ; Contador de vocales m?ximo
    MAX_INDEX DB 0               ; ?ndice de la cadena con m?s vocales

.CODE

MAIN PROC
    MOV AX, SEG @data
    MOV DS, AX

    ; Ciclo para leer 5 cadenas
    MOV CX, 5
    MOV DI, 0                    ; ?ndice para la ubicaci?n de cada cadena

    LEER_CADENA:
        MOV AH, 09H              ; Muestra el mensaje "Ingrese una cadena:"
        LEA DX, PROMPT
        INT 21H

        MOV AH, 0AH              ; Llamada de entrada de cadena
        LEA DX, CADENAS[DI]      ; Apunta a la posici?n de la cadena en el array
        INT 21H

        CALL CONTAR_VOCALES      ; Cuenta vocales en la cadena actual

        ; Actualiza el m?ximo si esta cadena tiene m?s vocales
        CMP AL, MAX_VOCALES
        JBE SIGUIENTE_CADENA
        MOV MAX_VOCALES, AL
        MOV AX, DI               ; Copia DI en AX
        MOV MAX_INDEX, AL        ; Almacena el valor bajo de AX en MAX_INDEX

    SIGUIENTE_CADENA:
        ADD DI, 31               ; Mueve al siguiente espacio en CADENAS
        LOOP LEER_CADENA

    ; Muestra el resultado
    MOV AH, 09H
    LEA DX, MSG_RESULT
    INT 21H

    ; Cargar la direcci?n de la cadena con m?s vocales usando MAX_INDEX
    MOV AL, MAX_INDEX            ; Cargar el ?ndice en AL
    MOV DI, AX                   ; Usar DI para apuntar a la cadena con m?s vocales
    LEA DX, CADENAS[DI]          ; Obtener la direcci?n de la cadena con m?s vocales
    MOV AH, 09H
    INT 21H

    MOV AH, 09H                  ; Salto de l?nea
    LEA DX, NL
    INT 21H

    MOV AH, 4CH                  ; Termina el programa
    INT 21H

MAIN ENDP

; Procedimiento para contar vocales en una cadena
CONTAR_VOCALES PROC
    MOV AL, 0                    ; Contador de vocales en AL
    MOV BL, 0                    ; Contador de vocales en BL
    MOV SI, 1                    ; Offset del primer caracter en la cadena

    MOV DL, CADENAS[DI]          ; Tama?o de la cadena en DL

    CONTAR:
        CMP SI, DX               ; Compara SI con el tama?o de la cadena
        JAE FIN_CONTAR           ; Si se lleg? al final, salir del ciclo

        ; Cargar caracter en CL usando indexaci?n con desplazamiento de DI y SI
        MOV BX, DI               ; Copia DI en BX para c?lculo de desplazamiento
        ADD BX, SI               ; Sumar SI para apuntar al car?cter actual
        MOV CL, CADENAS[BX]      ; Carga el caracter actual en CL
        CALL ES_VOCAL            ; Verifica si es vocal
        INC SI                   ; Pasa al siguiente caracter
        JMP CONTAR               ; Repetir ciclo

    FIN_CONTAR:
        MOV AL, BL               ; El n?mero de vocales en BL se guarda en AL
        RET
CONTAR_VOCALES ENDP

; Subrutina que verifica si el caracter en CL es una vocal
ES_VOCAL PROC
    MOV BH, CL                   ; Copia el caracter en BH para comparar

    CMP BH, 'A'
    JE SUMAR_VOCAL
    CMP BH, 'E'
    JE SUMAR_VOCAL
    CMP BH, 'I'
    JE SUMAR_VOCAL
    CMP BH, 'O'
    JE SUMAR_VOCAL
    CMP BH, 'U'
    JE SUMAR_VOCAL
    CMP BH, 'a'
    JE SUMAR_VOCAL
    CMP BH, 'e'
    JE SUMAR_VOCAL
    CMP BH, 'i'
    JE SUMAR_VOCAL
    CMP BH, 'o'
    JE SUMAR_VOCAL
    CMP BH, 'u'
    JE SUMAR_VOCAL
    JMP NO_ES_VOCAL

SUMAR_VOCAL:
    INC BL                      ; Aumenta el contador de vocales
NO_ES_VOCAL:
    RET
ES_VOCAL ENDP
END MAIN