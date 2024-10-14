.MODEL SMALL           ; Define el tipo de memoria como peque?a
.STACK 100h            ; Reserva espacio para la pila
.DATA                  ; Inicio de la secci?n de datos
    num1 DB 45         ; Primer n?mero de dos d?gitos (45 en este caso)
    num2 DB 78         ; Segundo n?mero de dos d?gitos (78 en este caso)
    msg1 DB 'Primer numero: $'  ; Mensaje para el primer n?mero
    msg2 DB 0DH, 0AH, 'Segundo numero: $'  ; Mensaje para el segundo n?mero, seguido de nueva l?nea

.CODE                  ; Inicio de la secci?n de c?digo
MAIN PROC
    MOV AX, SEG @data      ; Inicializa el segmento de datos
    MOV DS, AX         ; DS apunta al segmento de datos

    ; Mostrar el primer mensaje "Primer numero: "
    LEA DX, msg1       ; Cargar la direcci?n de msg1 en DX
    MOV AH, 09h        ; Funci?n de DOS para mostrar una cadena
    INT 21h            ; Llamada a la interrupci?n para mostrar msg1

    ; Mostrar el primer n?mero (num1)
    MOV AL, num1       ; Cargar el valor de num1 en AL
    CALL DISPLAY_NUMBER ; Llamada a la subrutina para desplegar el n?mero

    ; Mostrar el segundo mensaje "Segundo numero: "
    LEA DX, msg2       ; Cargar la direcci?n de msg2 en DX
    MOV AH, 09h        ; Funci?n de DOS para mostrar una cadena
    INT 21h            ; Llamada a la interrupci?n para mostrar msg2

    ; Mostrar el segundo n?mero (num2)
    MOV AL, num2       ; Cargar el valor de num2 en AL
    CALL DISPLAY_NUMBER ; Llamada a la subrutina para desplegar el n?mero

    ; Finalizar programa
    MOV AH, 4Ch        ; Funci?n de DOS para terminar el programa
    INT 21h            ; Llamada a la interrupci?n para terminar el programa

MAIN ENDP

; Subrutina para desplegar un n?mero de dos d?gitos en ASCII
DISPLAY_NUMBER PROC
    ; Dividir el n?mero en decenas y unidades
    XOR AH, AH         ; Limpiar el registro AH para evitar desbordamientos
    MOV BL, 10         ; BL = 10, para realizar la divisi?n
    DIV BL             ; AL = unidades, AH = decenas

    ; Convertir el d?gito de las decenas a ASCII
    ADD AH, 30h        ; Convertir el valor de las decenas a su c?digo ASCII
    MOV DL, AH         ; Mover el valor de las decenas a DL
    MOV AH, 02h        ; Funci?n de DOS para mostrar un car?cter
    INT 21h            ; Llamada a la interrupci?n para mostrar la decena

    ; Convertir el d?gito de las unidades a ASCII
    ADD AL, 30h        ; Convertir el valor de las unidades a su c?digo ASCII
    MOV DL, AL         ; Mover el valor de las unidades a DL
    MOV AH, 02h        ; Funci?n de DOS para mostrar un car?cter
    INT 21h            ; Llamada a la interrupci?n para mostrar la unidad

    RET               ; Retorno a la ejecuci?n principal
DISPLAY_NUMBER ENDP

END MAIN              ; Indica el final del programa principal
