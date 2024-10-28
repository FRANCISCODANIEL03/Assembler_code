.model small
.stack 64
.data
   
    msg db "EMILIANO ","$"
    
.code

inicio:
    mov ax, @data
    mov ds, ax
    mov ah, 09h
    mov dx, offset msg
    int 21h
    mov ah, 02
    mov dl, 0ah
    int 21h
    
    mov ah, 02
    mov dl, 0dh
    int 21h
    
    mov SI, 0
