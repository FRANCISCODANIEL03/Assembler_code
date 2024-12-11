.MODEL SMALL
   .STACK 64;16
.DATA
    ARRAY DB 10,20,3,4,5,6,7,8,9,0
    .CODE    
main proc
    mov ax,seg @data        ;Inicializar los registros.
    mov ds,ax
    mov cx,9
    Ciclo:
    mov si,cx
    add ARRAY[si],30h
    mov dl,ARRAY[si]
                      ;Coloca el array en el DX para quedar listo para ser impreso en pantalla.
    mov ah,02h           ;Servicio del video.
    int 21h                  ;Interrupcion del D.O.S
    LOOP Ciclo            ;Se supone decrementa el CX en 1
      
mov ax,4c00h
int 21h
