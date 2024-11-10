.model small
.stack 64

.data  ; Secci?n de datos
    numero1 db 0
    numero2 db 0
    mult db 0
    divi db 0
    modu db 0

    mensaje1 db 10, 13, "Ingresa el primer numero (0-99): $"
    mensaje2 db 10, 13, "Ingresa el segundo numero (0-99): $"
    mensaje3 db 10, 13, "La multiplicacion es: $"
    mensaje4 db 10, 13, "La division es: $"
    mensaje5 db 10, 13, "El modulo es: $"

.code  ; Secci?n de c?digo
begin proc far
    ; Inicializar el segmento de datos
    mov ax, @data
    mov ds, ax

    ; Leer el primer n?mero
    mov ah, 09h
    lea dx, mensaje1
    int 21h
    call read_number
    mov numero1, al   ; Almacenar el primer n?mero

    ; Leer el segundo n?mero
    mov ah, 09h
    lea dx, mensaje2
    int 21h
    call read_number
    mov numero2, al   ; Almacenar el segundo n?mero

    ; Multiplicaci?n
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    mul bl            ; Multiplicar AL por BL
    mov mult, al      ; Almacenar el resultado de la multiplicaci?n

    ; Divisi?n
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    xor ah, ah        ; Limpiar AH para la divisi?n
    cmp bl, 0        ; Comprobar si el divisor es cero
    je div_error      ; Si es cero, ir a div_error
    div bl            ; Dividir AL por BL
    mov divi, al      ; Almacenar el cociente

    ; M?dulo
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    xor ah, ah        ; Limpiar AH para la divisi?n
    div bl            ; Dividir AL por BL
    mov modu, ah      ; Almacenar el residuo (m?dulo)

    ; Mostrar la multiplicaci?n
    mov ah, 09h
    lea dx, mensaje3
    int 21h
    mov al, mult
    call print_number

    ; Mostrar la divisi?n
    mov ah, 09h
    lea dx, mensaje4
    int 21h
    mov al, divi
    call print_number

    ; Mostrar el m?dulo
    mov ah, 09h
    lea dx, mensaje5
    int 21h
    mov al, modu
    call print_number

    ; Salir del programa
    mov ax, 4C00h
    int 21h

div_error: ; Manejo de error de divisi?n
    mov ah, 09h
    lea dx, mensaje2
    int 21h
    mov ah, 02h
    mov dl, 'E'
    int 21h
    mov dl, 'r'
    int 21h
    mov dl, 'r'
    int 21h
    mov dl, 'o'
    int 21h
    mov dl, 'r'
    int 21h
    ret
begin endp

; Funci?n para leer un n?mero de hasta dos d?gitos
read_number proc
    xor ax, ax        ; Limpiar AX
    xor cx, cx        ; Limpiar CX (contador)

    ; Leer primer d?gito
    mov ah, 01h
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a n?mero
    mov bl, al        ; Guardar primer d?gito en BL

    ; Leer segundo d?gito
    mov ah, 01h
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a n?mero
    mov bh, al        ; Guardar segundo d?gito en BH

    ; Combinar los dos d?gitos en AL
    mov al, bl
    ; Multiplicar BL por 10 y sumar BH
    mov cx, 10
    mul cx            ; AL = AL * 10 (primer d?gito)
    add al, bh        ; AL = AL + segundo d?gito
read_done:
    ret
read_number endp

; Funci?n para imprimir un n?mero en AL
print_number proc
    ; Convertir AL a ASCII
    xor ah, ah        ; Limpiar AH para la conversi?n
    mov cx, 10        ; Divisor para obtener d?gitos
    xor dx, dx        ; Limpiar DX

    ; Convertir n?mero a ASCII
    push ax           ; Guardar AX en la pila
    mov bx, 10        ; Guardar 10 en BX para la conversi?n
    xor cx, cx        ; Limpiar CX (contador de d?gitos)

convert_loop:
    xor dx, dx        ; Limpiar DX
    div bx             ; AX = AX / 10, DX = AX % 10
    push dx           ; Guardar el resto (d?gito)
    inc cx            ; Incrementar el contador de d?gitos
    test ax, ax       ; Probar si AX es cero
    jnz convert_loop   ; Si no es cero, continuar

print_loop:
    pop dx            ; Recuperar el d?gito
    add dl, '0'       ; Convertir a ASCII
    mov ah, 02h       ; Funci?n para mostrar un car?cter
    int 21h           ; Imprimir el car?cter
    loop print_loop    ; Repetir para todos los d?gitos

    pop ax            ; Recuperar AX
    ret
print_number endp
end begin
