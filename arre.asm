.model small
.stack 100

.data

    arreglo db 7,4,5
    msg db "Elementos del arreglo: $"
    coma db ", $"
.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,09h
    lea dx,msg
    int 21h
    
    mov al,arreglo[0]
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h
        
    mov ah,09h
    lea dx,coma
    int 21h
    
    mov bl,arreglo[1]
    add bl,30h
    mov dl,bl
    mov ah,02h
    int 21h
    
    mov ah,09h
    lea dx,coma
    int 21h
    
    mov cl,arreglo[2]
    add cl,30h
    mov dl,cl
    mov ah,02h
    int 21h
    
    mov ah,4ch
    mov al,00h
    int 21h