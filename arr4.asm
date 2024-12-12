.model small
.stack 100h


.data

arreglo db 10,15,17
cadena db "ISICO  $"
var db 7
.code
main proc
mov ax, seg @data
mov ds,ax

mov ah,09h
lea dx,cadena
int 21h



mov al,arreglo[0]
mov bl,arreglo[1]
mov cl,arreglo[2]
AAM
mov ah,02
add al,30h
mov dl,al
int 21h

mov ah,02
add bl,30h
mov dl,bl
int 21h

mov ah,02
add cl,30h
mov dl,cl
int 21h
.exit
main endp

end main