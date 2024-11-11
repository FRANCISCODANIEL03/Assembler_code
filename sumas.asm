.model small
.stack

.data  ; Segmento de datos

    numero1 db 0
    numero2 db 0
    suma db 0
    resta db 0

    mensaje1 db 10, 13, "Ingresa el primer numero (0-9): $"
    mensaje2 db 10, 13, "Ingresa el segundo numero (0-9): $"
    mensaje3 db 10, 13, "La suma es: $"
    mensaje4 db 10, 13, "La resta es: $"
    saltoLinea db 10, 13, "$"

.code  ; Segmento de c?digo
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    ; Leer primer n?mero
    mov ah, 09h
    lea dx, mensaje1
    int 21h

    mov ah, 01h         ; Leer un car?cter de la entrada
    int 21h
    sub al, '0'         ; Convertir de ASCII a n?mero
    mov numero1, al

    ; Leer segundo n?mero
    mov ah, 09h
    lea dx, mensaje2
    int 21h

    mov ah, 01h         ; Leer un car?cter de la entrada
    int 21h
    sub al, '0'         ; Convertir de ASCII a n?mero
    mov numero2, al

    ; Calcular la suma
    mov al, numero1
    add al, numero2
    mov suma, al

    ; Calcular la resta
    mov al, numero1
    sub al, numero2
    mov resta, al

    ; Mostrar la suma
    mov ah, 09h
    lea dx, mensaje3
    int 21h

    mov al, suma
    add al, '0'         ; Convertir n?mero a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Salto de l?nea
    mov ah, 09h
    lea dx, saltoLinea
    int 21h

    ; Mostrar la resta
    mov ah, 09h
    lea dx, mensaje4
    int 21h

    mov al, resta
    add al, '0'         ; Convertir n?mero a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Finalizar el programa
    mov ax, 4c00h
    int 21h
main endp
end main
