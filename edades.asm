.MODEL SMALL
.STACK 100h

.DATA
    nombre1 DB 'Juan$'           ; Nombre asociado a la primera edad
    nombre2 DB 'Irma$'          ; Nombre asociado a la segunda edad
    edad1 DB 20                  ; Primera edad
    edad2 DB 20                  ; Segunda edad
    mayor_msg DB ' Tiene la mayor edad$'
    iguales_msg DB 'Ambas edades son iguales$'

.CODE
MAIN:
    ; Inicializar el segmento de datos
    MOV AX, @data                ; Cargar el segmento de datos correctamente
    MOV DS, AX                   ; Inicializar el segmento de datos en DS

    ; Comparar las edades
    MOV AL, edad1                ; Mover edad1 a AL
    MOV BL, edad2                ; Mover edad2 a BL
    CMP AL, BL
    JE IGUALES                   ; Si son iguales, saltar a IGUALES
    JA MAYOR                     ; Si edad1 > edad2, saltar a MAYOR

    ; Si llegamos aqu?, edad2 es mayor
MENOR:
    LEA DX, nombre2              ; Cargar nombre2
    CALL IMPRIMIR_CADENA          ; Imprimir nombre2
    LEA DX, mayor_msg            ; Cargar el mensaje 'tiene la mayor edad'
    CALL IMPRIMIR_CADENA          ; Imprimir el mensaje
    JMP FIN                      ; Saltar a FIN

MAYOR:
    LEA DX, nombre1              ; Cargar nombre1
    CALL IMPRIMIR_CADENA          ; Imprimir nombre1
    LEA DX, mayor_msg            ; Cargar el mensaje 'tiene la mayor edad'
    CALL IMPRIMIR_CADENA          ; Imprimir el mensaje
    JMP FIN                      ; Saltar a FIN

IGUALES:
    LEA DX, iguales_msg          ; Cargar el mensaje 'Ambas edades son iguales'
    CALL IMPRIMIR_CADENA          ; Imprimir el mensaje

FIN:
    ; Salir del programa
    MOV AX, 4C00h                ; Funci?n de DOS para terminar el programa
    INT 21h

; Subrutina para imprimir cadenas
IMPRIMIR_CADENA PROC
    MOV AH, 09h                  ; Funci?n de DOS para imprimir cadena
    INT 21h
    RET
IMPRIMIR_CADENA ENDP

END MAIN
