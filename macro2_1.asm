.model small
.stack
.data

    mensaje1 db 10,13,7,"Resultado de la pila:  ","$"
    espacio db 10,13,7,"   ","$"

.code
main proc

    mov ax, SEG @data
    mov ds,ax

    mov ah,09h
    lea dx,mensaje1
    int 21h

    mov dx,0e59h
    mov cx,0e41h
    mov bx,0e4bh
    mov ax,0e4fh

    push ax
    push bx
    push cx
    push dx  

    mov bx,0071h
    mov ah,09h
    lea dx,espacio
    int 21h
    pop ax
    int 10h

    mov ah,09h
    lea dx,espacio
    int 21h
    pop ax
    int 10h
    mov ah,09h
    lea dx,espacio
    int 21h
    pop ax
    int 10h
    mov ah,09h
    lea dx,espacio
    int 21h
    pop ax
    int 10h
    mov ah,09h
    lea dx,espacio
    int 21h

    mov ax,4c00h;salir del programa
    int 21h
main endp;termina procedimiento
end main