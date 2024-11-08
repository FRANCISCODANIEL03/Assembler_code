imprime_caracter macro caracter
    mov ah,02h
    mov dl, caracter
    int 21h
    endm
    
    
imprimir macro cadena
   mov ah,09h
lea dx,mensaje1
int 21h


mov ax,0e59h
mov bx,0e41h
mov cx,0e4bh
mov dx,0e4fh

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

    int 21h
endm
