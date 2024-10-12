.model small
.stack 100h

.data
    msg1 db 13,10,'Ingrese el primer numero: $'
    msg2 db 13,10,'Ingrese el segundo numero: $'
    result_msg db 13,10,'El numero menor es: $'
    num1 db 0
    num2 db 0
    menor db 0
    new_line db 0Dh, 0Ah, '$'

.code
main:
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el primer n?mero
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Leer el primer n?mero desde el teclado
    call leer_numero
    mov [num1], al  ; Guardar el primer n?mero en num1

    ; Solicitar el segundo n?mero
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Leer el segundo n?mero desde el teclado
    call leer_numero
    mov [num2], al  ; Guardar el segundo n?mero en num2

    ; Comparar los dos n?meros
    mov al, [num1]
    cmp al, [num2]
    jl num1_menor    ; Si num1 es menor, saltar a num1_menor

    ; Si num2 es menor o igual
    mov al, [num2]
    jmp imprimir_menor

num1_menor:
    mov al, [num1]

imprimir_menor:
    ; Mostrar mensaje del resultado
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; Convertir el n?mero menor a car?cter e imprimirlo
    call imprimir_numero

    ; Imprimir nueva l?nea
    mov ah, 09h
    lea dx, new_line
    int 21h

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

; Leer un n?mero desde el teclado
leer_numero:
    mov ah, 01h      ; Funci?n para leer un car?cter
    int 21h          ; Leer el car?cter
    sub al, '0'      ; Convertir de car?cter a n?mero
    ret

; Imprimir un n?mero
imprimir_numero:
    add al, '0'      ; Convertir de n?mero a car?cter
    mov ah, 02h      ; Funci?n para imprimir un car?cter
    mov dl, al       ; Cargar el car?cter en DL
    int 21h          ; Imprimir el car?cter
    ret

end main
