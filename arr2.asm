.model small
.stack 100h


.data

arreglo db 1,2,3
cadena db "ISIC  $"
var db 7
.code
main proc
mov ax, seg @data
mov ds,ax

mov ah,09h
lea dx,cadena
int 21h

;mov arreglo[0],30h
;mov arreglo[1],30h
;mov arreglo[2],30h

mov al,arreglo[0]
mov bl,arreglo[1]
mov cl,arreglo[2]

add al,30h
mov dl,al
mov ah,02h
int 21h

add bl,30h
mov dl,bl
mov ah,02h
int 21h

add cl,30h
mov dl,cl
mov ah,02h
int 21h