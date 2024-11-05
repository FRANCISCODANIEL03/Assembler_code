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

main endp
end main
