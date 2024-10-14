.model small
.stack 100h

.data
    msg db 'Numeros del 1 al 99: $'
    new_line db ' - $'  ; Nueva l?nea

.code
main:
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Imprimir mensaje inicial
    mov ah, 09h
    lea dx, msg
    int 21h

    ; Inicializar el contador en 1
    mov bx, 1               ; Contador de n?meros, comienza en 1

print_loop:
    ; Imprimir el n?mero en BX
    call print_number

    ; Saltar a la siguiente l?nea
    mov ah, 09h
    lea dx, new_line
    int 21h

    ; Incrementar el contador
    inc bx                  ; Aumentar el n?mero
    cmp bx, 100             ; Comparar con 100
    jl print_loop          ; Repetir hasta que BX sea igual a 100

    ; Terminar el programa
    mov ax, 4C00h
    int 21h

; Procedimiento para imprimir un n?mero en BX
print_number:
    ; Convertir el n?mero en BX a cadena
    ; Almacenar en la pila para convertir a caracteres
    push bx                 ; Guardar BX en la pila
    mov ax, bx              ; Mover el n?mero a AX

    ; Convertir n?mero a cadena (separar d?gitos)
    xor cx, cx              ; Limpiar CX (n?mero de d?gitos)
    mov dx, 0               ; Limpiar DX

convert_loop:
    xor dx, dx              ; Limpiar DX antes de dividir
    mov bx, 10              ; Divisor
    div bx                  ; AX / BX; cociente en AX, residuo en DX
    push dx                 ; Guardar el residuo en la pila
    inc cx                  ; Contar los d?gitos
    test ax, ax             ; Verificar si el cociente es cero
    jnz convert_loop        ; Si no es cero, continuar

    ; Imprimir los d?gitos en orden
print_digits:
    pop dx                  ; Obtener el d?gito de la pila
    add dl, '0'             ; Convertir a car?cter
    mov ah, 02h             ; Funci?n de impresi?n de car?cter
    int 21h                 ; Llamar a DOS para imprimir
    loop print_digits       ; Imprimir todos los d?gitos

    pop bx                  ; Recuperar BX de la pila
    ret                     ; Regresar

end main
