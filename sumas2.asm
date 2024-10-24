.model small
.stack 100h

.data
    msg1 db 10,13,"Ingrese el primer numero (0-99): $"
    msg2 db 10,13,"Ingrese el segundo numero (0-99): $"
    sum_msg db 10,13,"La suma es: $"
    sub_msg db 10,13,"La resta es: $"
    num1 db 0
    num2 db 0
    result db 0   ; Declarar la variable result aqu?

.code
main proc
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Solicitar el primer n?mero
    mov ah, 09h
    lea dx, msg1
    int 21h

    ; Leer el primer n?mero
    call read_number
    mov num1, al  ; Guardar el primer n?mero en num1

    ; Solicitar el segundo n?mero
    mov ah, 09h
    lea dx, msg2
    int 21h

    ; Leer el segundo n?mero
    call read_number
    mov num2, al  ; Guardar el segundo n?mero en num2

    ; Calcular la suma
    mov al, num1
    add al, num2
    mov result, al ; Guardar la suma en result

    ; Mostrar la suma
    mov ah, 09h
    lea dx, sum_msg
    int 21h
    call print_number

    ; Calcular la resta
    mov al, num1
    sub al, num2
    mov result, al ; Guardar la resta en result

    ; Mostrar la resta
    mov ah, 09h
    lea dx, sub_msg
    int 21h
    call print_number

    ; Finalizar el programa
    mov ax, 4C00h
    int 21h
main endp

; Funci?n para leer un n?mero de hasta dos d?gitos
read_number proc
    xor ax, ax        ; Limpiar AX
    xor cx, cx        ; Limpiar CX (contador)
    xor bx, bx        ; Limpiar BX (acumulador)

    ; Leer primer d?gito
    mov ah, 01h       ; Leer un car?cter
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a n?mero
    mov bl, al        ; Guardar primer d?gito en BL

    ; Leer segundo d?gito
    mov ah, 01h       ; Leer un car?cter
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a n?mero
    mov bh, al        ; Guardar segundo d?gito en BH

    ; Combinar los dos d?gitos en AL
    mov al, bl
    mov ah, 0         ; Limpiar AH
    ; Multiplicar BL por 10 y sumar BH
    mov cx, 10
    mul cx            ; AL = AL * 10 (primer d?gito)
    add al, bh        ; AL = AL + segundo d?gito
read_done:
    ret
read_number endp

; Funci?n para imprimir un n?mero en AL
print_number proc
    mov ah, 0        ; Limpiar AH
    xor cx, cx       ; Limpiar CX para usarlo como contador

    ; Convertir AL a cadena
    mov bx, 10       ; Divisor para decimal
convert_loop:
    xor dx, dx       ; Limpiar DX para la divisi?n
    div bx            ; AX / 10
    push dx           ; Guardar el resto (d?gito)
    inc cx            ; Contar d?gitos
    test ax, ax      ; Verificar si AX es cero
    jnz convert_loop

    ; Imprimir los d?gitos en orden inverso
print_loop:
    pop dx            ; Recuperar el d?gito
    add dl, '0'       ; Convertir a car?cter ASCII
    mov ah, 02h       ; Funci?n para imprimir car?cter
    int 21h
    loop print_loop   ; Repetir para todos los d?gitos
    ret
print_number endp

end main
