; Utilizar el salto JBE
.MODEL SMALL
.STACK 

.DATA
    edad1 DB 40                  ; Primera edad
    edad2 DB 40                  ; Segunda edad
    msg1 DB 13,10,'La primera edad es mayor','$'
    msg2 DB 13,10,'La segunda edad es mayor','$'
    iguales_msg DB 13,10,'Ambas edades son iguales','$'

.CODE
MAIN :
    MOV AX, SEG @data          ; Cargar el segmento de datos
    MOV DS, AX                   ; Inicializar el segmento de datos en DS


    ; Comparar las edades-
    MOV AL, edad1                ; Mover edad1 a AL
    MOV BL, edad2                ; Mover edad2 a BL
    CMP AL, BL
    JE IGUALES                   ; Si son iguales, saltar a IGUALES
    JA MAYOR                     ; Si edad1 > edad2, saltar a MAYOR
    JBE MENOR                    ; Si edad1 < edad2, saltar a MENOR

MENOR:
    LEA DX, msg1            ; Cargar el mensaje 'tiene la menor edad'
    JMP IMPRIMIR

MAYOR:
    LEA DX, msg2            ; Cargar el mensaje 'tiene la mayor edad'
    JMP IMPRIMIR

IGUALES:
    LEA DX, iguales_msg          ; Cargar el mensaje 'Ambas edades son iguales'
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