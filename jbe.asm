; Utilizar el salto JBE
.MODEL SMALL
.STACK 

.DATA
    edad1 DB 18                  ; Primera edad
    edad2 DB 17                  ; Segunda edad
    msg1 DB 13,10,'Eres menor de edad','$'
    msg2 DB 13,10,'Eres mayor de edad','$'

.CODE
MAIN :
    MOV AX, SEG @data          ; Cargar el segmento de datos
    MOV DS, AX                   ; Inicializar el segmento de datos en DS

    ; Comparar las edades-
    MOV AL, edad1                ; Mover edad1 a AL
    MOV BL, edad2                ; Mover edad2 a BL
    CMP AL, BL
    JBE MENOR                    ; Si edad1 < edad2, saltar a MENOR

MAYOR:
    LEA DX, msg2            ; Cargar el mensaje 'tiene la mayor edad'
    JMP IMPRIMIR

MENOR:
    LEA DX, msg1            ; Cargar el mensaje 'tiene la menor edad'
    JMP IMPRIMIR

IMPRIMIR:
    CALL IMPRIMIR_CADENA         ; Llamada para imprimir la cadena

    ; Salir del programa
    MOV AH, 4Ch                  ; Funci?n de DOS para terminar el programa
    INT 21h

; Subrutina para imprimir cadenas
IMPRIMIR_CADENA PROC
    MOV AH, 09h                  ; Funci?n de DOS para imprimir cadena
    INT 21h
    RET
IMPRIMIR_CADENA ENDP

END MAIN
