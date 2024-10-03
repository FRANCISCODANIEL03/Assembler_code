.model small
.stack
.data
mensaje db "   ",10,13,"$"
.code
main proc
mov cx,5
ciclo:
    mov ax, SEG @data   ;se asigna la localizacion del segmento de datos
    mov ds,ax   ;coloca los datos contenidos en ax en el segmento de datos
    mov ah,09   ;se imprime la cadena
    lea dx,mensaje  ;leer mensaje
    int 21h
    mov ah,02
    mov dx,cx
    add dx,30h
    int 21h

loop ciclo

mov ax,4c00h
int 21h
main endp
end main
