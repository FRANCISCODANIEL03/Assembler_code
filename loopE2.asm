.model small      ; Definir el modelo de memoria peque?o
.stack 100h       ; Definir el tama?o de la pila

.data
    msg db 13,10,'Numero: $'  ; Mensaje a imprimir

.code
_start:
    mov ax, @data      ; Inicializar segmento de datos
    mov ds, ax         ; Cargar DS con el valor de AX (segmento de datos)
    
    ; Inicializar el valor del contador
    mov cx, 9          ; Cargar 9 en CX (cuenta hasta 9)

    mov al, 1          ; Inicializamos AL con 1 para empezar el conteo

loop_start:
    ; Imprimir el texto "Conteo: "
    mov ah, 09h        ; Funci?n de DOS para imprimir string
    lea dx, msg        ; Cargar la direcci?n del mensaje
    int 21h            ; Llamar a la interrupci?n de DOS

    ; Convertir el valor en AL a ASCII
    add al, 30h        ; Convertir a ASCII (sumar 48)
    
    ; Imprimir el n?mero
    mov dl, al         ; Mover el n?mero ASCII a DL
    mov ah, 02h        ; Funci?n de DOS para imprimir un solo car?cter
    int 21h            ; Llamar a la interrupci?n de DOS

    ; Volver a convertir el valor de AL de ASCII a n?mero
    sub al, 30h        ; Restar 48 para volver al valor num?rico

    ; Incrementar el valor en AL
    inc al             ; Incrementar AL para el siguiente n?mero

    ; Decrementar el contador y verificar si ya hemos contado 9 n?meros
    loop loop_start    ; Decrementar CX y saltar si CX != 0

    ; Terminar el programa
    mov ah, 4Ch        ; Funci?n para terminar el programa
    int 21h            ; Llamar a la interrupci?n de DOS

end _start
