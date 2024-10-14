.model small
.stack 100h
.data

num1 dw 0
num2 dw 0
num3 dw 0

mensaje db 10,13,6, " Primer numero: ","$"
mensaje2 db 10,13,6, " Segundo numero: ","$" 
mensaje3 db 10,13,6, " La suma es: ","$"

.code 
main proc 
    mov ax, SEG @data
    mov ds,ax

    mov ah,09h
    lea dx,mensaje
    int 21h

    mov ah,01h
    int 21h
    sub al,30h
    mov num1,al
    
    mov al, bl
    mov ah, 0
    mov cx, 10
    mul cx                ; Multiplicar por 10 para obtener decenas
    add ax, bh            ; Sumar las unidades
    mov num1, ax 

    mov ah,09h
    lea dx,mensaje2
    int 21h

    mov ah,01h
    int 21h
    sub al,30h
    mov num2,al

    mov al,num1
    add al,num2
    add al,30h
    mov num3,al

    mov ah,09
    lea dx,mensaje3
    int 21h
    mov ah,02
    mov dl,num3
    int 21h

    mov ax,4c00h
    int 21h

main endp

end main

