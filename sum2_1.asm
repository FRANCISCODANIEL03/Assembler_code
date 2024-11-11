.model small
.stack 
.data

    num1 dw 0       ; Para almacenar el primer n?mero de dos d?gitos
    num2 dw 0       ; Para almacenar el segundo n?mero de dos d?gitos
    resultado dw 0  ; Para almacenar el resultado de la suma

    mensaje db 10,13,6, "Primer numero (2 digitos): ","$"
    mensaje2 db 10,13,6, "Segundo numero (2 digitos): ","$" 
    mensaje3 db 10,13,6, "La suma es: ","$"

.code 
main proc
    mov ax, @data
    mov ds, ax

    ; Solicitar primer n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensaje
    int 21h

    ; Leer primer d?gito del primer n?mero
    mov ah, 01h
    int 21h
    sub al, 30h           ; Convertir de ASCII a valor num?rico
    mov bl, al            ; Guardar primer d?gito en BL

    ; Leer segundo d?gito del primer n?mero
    mov ah, 01h
    int 21h
    sub al, 30h           ; Convertir de ASCII a valor num?rico
    mov bh, al            ; Guardar segundo d?gito en BH

    ; Calcular el valor del primer n?mero (decenas y unidades)
    mov al, bl
    mov ah, 0
    mov cx, 10
    mul cx                ; Multiplicar por 10 para obtener decenas

    ; Sumar las unidades (limpiar ah antes de usar bh)
    mov ah, 0             ; Limpiar el registro alto
    add ax, bx            ; Sumar las unidades (donde bx = 00hh)
    mov num1, ax          ; Guardar el primer n?mero

    ; Solicitar segundo n?mero (2 d?gitos)
    mov ah, 09h
    lea dx, mensaje2
    int 21h

    ; Leer primer d?gito del segundo n?mero
    mov ah, 01h
    int 21h
    sub al, 30h           ; Convertir de ASCII a valor num?rico
    mov bl, al            ; Guardar primer d?gito en BL

    ; Leer segundo d?gito del segundo n?mero
    mov ah, 01h
    int 21h
    sub al, 30h           ; Convertir de ASCII a valor num?rico
    mov bh, al            ; Guardar segundo d?gito en BH

    ; Calcular el valor del segundo n?mero (decenas y unidades)
    mov al, bl
    mov ah, 0
    mul cx                ; Multiplicar por 10 para obtener decenas

    ; Sumar las unidades (limpiar ah antes de usar bh)
    mov ah, 0             ; Limpiar el registro alto
    add ax, bx            ; Sumar las unidades
    mov num2, ax          ; Guardar el segundo n?mero

    ; Sumar los dos n?meros
    mov ax, num1
    add ax, num2
    mov resultado, ax      ; Guardar el resultado

    ; Mostrar el mensaje "La suma es:"
    mov ah, 09h
    lea dx, mensaje3
    int 21h

    ; Convertir el resultado en decenas y unidades
    mov ax, resultado
    mov bx, 10
    div bx                ; Dividir entre 10, el cociente queda en AL (decenas) y el resto en AH (unidades)

    ; Mostrar las decenas
    add al, 30h           ; Convertir decenas a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Mostrar las unidades
    add ah, 30h           ; Convertir unidades a ASCII
    mov dl, ah
    mov ah, 02h
    int 21h

    ; Terminar el programa
    mov ax, 4c00h
    int 21h
main endp
end main
