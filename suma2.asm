.model small
.stack 100h
.data

num1 dw 0       ; Almacenar el primer n?mero
num2 dw 0       ; Almacenar el segundo n?mero
resultado dw 0  ; Almacenar el resultado de la suma

mensaje db 10,13, "Ingrese el primer numero (2 digitos): $"
mensaje2 db 10,13, "Ingrese el segundo numero (2 digitos): $"
mensaje3 db 10,13, "La suma es: $"

.code
main proc
    mov ax, @data        ; Inicializar segmento de datos
    mov ds, ax

    ; Solicitar el primer n?mero
    mov ah, 09h
    lea dx, mensaje
    int 21h

    ; Leer primer d?gito del primer n?mero
    mov ah, 01h          ; Leer car?cter
    int 21h
    sub al, 30h          ; Convertir de ASCII a valor num?rico
    mov bl, al           ; Guardar primer d?gito en BL

    ; Leer segundo d?gito del primer n?mero
    mov ah, 01h
    int 21h
    sub al, 30h          ; Convertir de ASCII a valor num?rico
    mov bh, al           ; Guardar segundo d?gito en BH

    ; Convertir los d?gitos del primer n?mero a un valor num?rico
    mov al, bl           ; AL = primer d?gito
    mov ah, 0
    mov cx, 10
    mul cx               ; Multiplicar por 10 (decenas)
    add al, bh           ; Sumar las unidades
    mov num1, ax         ; Guardar el primer n?mero en num1

    ; Solicitar el segundo n?mero
    mov ah, 09h
    lea dx, mensaje2
    int 21h

    ; Leer primer d?gito del segundo n?mero
    mov ah, 01h
    int 21h
    sub al, 30h          ; Convertir de ASCII a valor num?rico
    mov bl, al           ; Guardar primer d?gito en BL

    ; Leer segundo d?gito del segundo n?mero
    mov ah, 01h
    int 21h
    sub al, 30h          ; Convertir de ASCII a valor num?rico
    mov bh, al           ; Guardar segundo d?gito en BH

    ; Convertir los d?gitos del segundo n?mero a un valor num?rico
    mov al, bl           ; AL = primer d?gito
    mov ah, 0
    mul cx               ; Multiplicar por 10 (decenas)
    add al, bh           ; Sumar las unidades
    mov num2, ax         ; Guardar el segundo n?mero en num2

    ; Sumar los dos n?meros
    mov ax, num1
    add ax, num2
    mov resultado, ax     ; Guardar el resultado en resultado

    ; Mostrar el mensaje "La suma es:"
    mov ah, 09h
    lea dx, mensaje3
    int 21h

    ; Convertir el resultado en decenas y unidades
    mov ax, resultado
    mov bx, 10
    xor dx, dx           ; Limpiar DX antes de la divisi?n
    div bx               ; Dividir entre 10, el cociente queda en AL (decenas) y el resto en AH (unidades)

    ; Mostrar las decenas
    add al, 30h          ; Convertir decenas a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Mostrar las unidades
    mov al, ah           ; Mover las unidades a AL
    add al, 30h          ; Convertir unidades a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Finalizar el programa
    mov ax, 4c00h
    int 21h

main endp
end main