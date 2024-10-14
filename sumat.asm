.model small
.stack 100h
.data
    sum dw 0       ; Variable para almacenar la suma
    i dw 1         ; Contador de la suma, comenzando en 1
    temp dw 0      ; Variable temporal para calcular i + 1
    mensaje db 'La suma es: $'
    resultado db 5 dup('$')  ; Para almacenar el resultado en formato ASCII
.code
start:
    mov ax, @data
    mov ds, ax      ; Inicializar segmento de datos
    
    mov cx, 20      ; Se repetir? 20 veces (i = 1 a 20)

sum_loop:
    mov ax, i       ; Mover el valor de i a AX
    add ax, 1       ; Sumar 1 a i
    mov temp, ax    ; Guardar el resultado temporal en temp
    
    mov ax, temp    ; Mover el valor de temp al registro AX
    add sum, ax     ; A?adir AX (que contiene temp) a sum
    
    inc i           ; Incrementar i
    loop sum_loop   ; Repetir el ciclo hasta que cx llegue a 0

    ; Mostrar el mensaje "La suma es:"
    mov ah, 09h
    lea dx, mensaje
    int 21h
    
    ; Convertir la suma a formato ASCII para mostrarla
    mov ax, sum
    call print_num
    
    ; Esperar a que el usuario presione una tecla antes de salir
    mov ah, 01h
    int 21h

    ; Salir del programa
    mov ah, 4Ch
    int 21h

; Rutina para imprimir un n?mero en pantalla
print_num:
    mov bx, 10
    xor cx, cx

convert_loop:
    xor dx, dx          ; Poner en 0 el registro
    div bx             ; Dividir ax por 10
    add dl, '0'        ; Convertir el d?gito a ASCII
    push dx            ; Guardar el d?gito en la pila
    inc cx             ; Incrementar contador de d?gitos
    test ax, ax        ; Comprobar si el cociente es 0
    jnz convert_loop   ; Si no es 0, repetir

print_loop:
    pop dx             ; Recuperar el d?gito de la pila
    mov ah, 02h        ; Funci?n DOS para mostrar un car?cter
    int 21h
    loop print_loop    ; Repetir hasta que todos los d?gitos hayan sido mostrados
    ret
end start