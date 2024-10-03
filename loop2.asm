.model small    ;se asigna formato de memoria
.stack  ;modelo de pila

.data   ;inicio de datos

mensaje db "Tecnologico de Estudios Superiores de Jilotepec","$"    ;mensaje
mensaje2 db 10,13,4,"Ingenieria en sistemas computacionales","$"
mensaje3 db 10,13,"                                          ",10,13,"$"

.code   ;inicio de codigo


main proc   ;inicia proceso principal
    main proc
    mov cx,5
    ciclo:
    mov ax, SEG @data   ;se asigna la localizacion del segmento de datos
    mov ds,ax   ;coloca los datos contenidos en ax en el segmento de datos
    mov ah,09   ;se imprime la cadena
    lea dx,mensaje  ;leer mensaje
    int 21h
    lea dx,mensaje2 
    int 21h     ;funcion de interrupcion que invoca al DOS
    mov ah,09
    lea dx,mensaje3
    int 21h
    
    loop ciclo
    
    mov ax,4c00h    ;salir del programa
    int 21h
main endp  ;termina procedimiento

end main