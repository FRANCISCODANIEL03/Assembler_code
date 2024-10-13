.model small      ; Definir el modelo de memoria peque?o
.stack 100h       ; Definir el tama?o de la pila

.data
    msg db 13,10,'Numero: $'  ; Mensaje a imprimir

.code
_start:
    mov ax, @data      ; Inicializar segmento de datos
    mov ds, ax         ; Cargar DS con el valor de AX (segmento de datos)
    
    ; Inicializar el valor del contador
    mov cx, 10         ; Cargar 10 en CX (cuenta desde 9 hasta 0)

loop_start:
    ; Imprimir el texto "Conteo: "
    mov ah, 09h        ; Funci?n de DOS para imprimir string
    lea dx, msg        ; Cargar la direcci?n del mensaje
    int 21h            ; Llamar a la interrupci?n de DOS

    ; Calcular el valor a imprimir (CX - 1) y convertir a ASCII
    mov ax, cx         ; Copiar el valor de CX en AX
    dec ax             ; Decrementar para obtener el n?mero a imprimir (9 a 0)
    add al, 30h        ; Convertir a ASCII (sumar 48)
    
    ; Imprimir el n?mero
    mov dl, al         ; Mover el n?mero ASCII a DL
    mov ah, 02h        ; Funci?n de DOS para imprimir un solo car?cter
    int 21h            ; Llamar a la interrupci?n de DOS

    ; Volver a convertir el valor de AL de ASCII a n?mero
    sub al, 30h        ; Restar 48 para volver al valor num?rico

    ; Realizar el bucle de conteo descendente
    loop loop_start    ; Decrementar CX y saltar si CX != 0

    ; Terminar el programa
    mov ah, 4Ch        ; Funci?n para terminar el programa
    int 21h            ; Llamar a la interrupci?n de DOS

end _start
