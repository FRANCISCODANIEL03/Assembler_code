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
    
  
main endp
end main
