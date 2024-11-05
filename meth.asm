.model small
.stack

.data  ; Segmento de datos

numero1 db 0
numero2 db 0
suma db 0
resta db 0
mult db 0
divi db 0
modu db 0

mensaje1 db 10, 13, "Ingresa el primer numero (0-99): $"
mensaje2 db 10, 13, "Ingresa el segundo numero (0-99): $"
mensaje3 db 10, 13, "La suma es: $"
mensaje4 db 10, 13, "La resta es: $"
mensaje5 db 10, 13, "La multiplicacion es: $"
mensaje6 db 10, 13, "La division es: $"
mensaje7 db 10, 13, "El modulo es: $"
saltoLinea db 10, 13, "$"

.code  ; Segmento de codigo
main proc
    ; Inicializar segmento de datos
    mov ax, @data
    mov ds, ax

    call suma_resta_mult_div_mod
    
    ; Finalizar el programa
    mov ax, 4c00h
    int 21h
    
    div_error: ; Manejo de error de division
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
    
suma_resta_mult_div_mod proc

 ; Leer el primer numero
    mov ah, 09h
    lea dx, mensaje1
    int 21h
    call read_number
    mov numero1, al   ; Almacenar el primer numero

    ; Leer el segundo numero
    mov ah, 09h
    lea dx, mensaje2
    int 21h
    call read_number
    mov numero2, al   ; Almacenar el segundo numero

    ; Calcular la suma
    mov al, numero1
    add al, numero2
    mov suma, al

    ; Calcular la resta
    mov al, numero1
    sub al, numero2
    mov resta, al
    
    ; Multiplicacion
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    mul bl            ; Multiplicar AL por BL
    mov mult, al      ; Almacenar el resultado de la multiplicacion

    ; Division
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    xor ah, ah        ; Limpiar AH para la division
    cmp bl, 0        ; Comprobar si el divisor es cero
    je div_error      ; Si es cero, ir a div_error
    div bl            ; Dividir AL por BL
    mov divi, al      ; Almacenar el cociente
    
    ; Modulo
    mov al, numero1
    mov bl, numero2   ; Mover numero2 a BL
    xor ah, ah        ; Limpiar AH para la division
    div bl            ; Dividir AL por BL
    mov modu, ah      ; Almacenar el residuo (modulo) 

    ; Mostrar la suma
    mov ah, 09h
    lea dx, mensaje3
    int 21h
    mov al, suma
    call print_number

    ; Mostrar la resta
    mov ah, 09h
    lea dx, mensaje4
    int 21h
    mov al, resta
    call print_number
      
    ; Mostrar la multiplicacion
    mov ah, 09h
    lea dx, mensaje5
    int 21h
    mov al, mult
    call print_number
    
    ; Mostrar la division
    mov ah, 09h
    lea dx, mensaje6
    int 21h
    mov al, divi
    call print_number
    
    ; Mostrar el modulo
    mov ah, 09h
    lea dx, mensaje7
    int 21h
    mov al, modu
    call print_number
    
    ret
suma_resta_mult_div_mod endp
    
read_number proc
    xor ax, ax        ; Limpiar AX
    xor cx, cx        ; Limpiar CX (contador)

    ; Leer primer digito
    mov ah, 01h
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a numero
    mov bl, al        ; Guardar primer digito en BL

    ; Leer segundo d?gito
    mov ah, 01h
    int 21h
    cmp al, 13        ; Verificar si es Enter
    je read_done
    sub al, '0'       ; Convertir de ASCII a numero
    mov bh, al        ; Guardar segundo digito en BH

    ; Combinar los dos digitos en AL
    mov al, bl
    ; Multiplicar BL por 10 y sumar BH
    mov cx, 10
    mul cx            ; AL = AL * 10 (primer digito)
    add al, bh        ; AL = AL + segundo digito
read_done:
    ret
read_number endp

; Funcion para imprimir un numero en AL
print_number proc
    ; Convertir AL a ASCII
    xor ah, ah        ; Limpiar AH para la conversion
    mov cx, 10        ; Divisor para obtener digitos
    xor dx, dx        ; Limpiar DX

    ; Convertir numero a ASCII
    push ax           ; Guardar AX en la pila
    mov bx, 10        ; Guardar 10 en BX para la conversion
    xor cx, cx        ; Limpiar CX (contador de d?gitos)

convert_loop:
    xor dx, dx        ; Limpiar DX
    div bx             ; AX = AX / 10, DX = AX % 10
    push dx           ; Guardar el resto (digito)
    inc cx            ; Incrementar el contador de digitos
    test ax, ax       ; Probar si AX es cero
    jnz convert_loop   ; Si no es cero, continuar

print_loop:
    pop dx            ; Recuperar el digito
    add dl, '0'       ; Convertir a ASCII
    mov ah, 02h       ; Funci?n para mostrar un caracter
    int 21h           ; Imprimir el caracter
    loop print_loop    ; Repetir para todos los digitos

    pop ax            ; Recuperar AX
    ret
print_number endp 
main endp
end main
