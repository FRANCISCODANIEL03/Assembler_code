suma_resta macro num1,num2

 ; Leer primer numero
    mov ah, 09h
    lea dx, mensaje1
    int 21h

    mov ah, 01h         ; Leer un caracter de la entrada
    int 21h
    sub al, '0'         ; Convertir de ASCII a numero
    mov numero1, al

    ; Leer segundo n?mero
    mov ah, 09h
    lea dx, mensaje2
    int 21h

    mov ah, 01h         ; Leer un caracter de la entrada
    int 21h
    sub al, '0'         ; Convertir de ASCII a numero
    mov num2, al

    ; Calcular la suma
    mov al, num1
    add al, num2
    mov suma, al

    ; Calcular la resta
    mov al, num1
    sub al, num2
    mov resta, al

    ; Mostrar la suma
    mov ah, 09h
    lea dx, mensaje3
    int 21h

    mov al, suma
    add al, '0'         ; Convertir numero a ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Salto de linea
    mov ah, 09h
    lea dx, saltoLinea
    int 21h

    ; Mostrar la resta
    mov ah, 09h
    lea dx, mensaje4
    int 21h

    mov al, resta
    add al, '0'         ; Convertir numero a ASCII
    mov dl, al
    mov ah, 02h
    int 21h
      
endm
