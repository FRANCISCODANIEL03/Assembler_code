CR EQU 13 ;retorno de acarreo

LF EQU 10 ;Salto de linea

Datos Segment 

    Mensaje db CR,LF,'Hola Mundo (con funciones o procesos',CR,LF,'$'
    
Datos Ends

Pila Segment Stack

    db 64 DUP('PILA') ;inicializacion de la pila
    
Pila Ends

Codigo Segment 

holam3 proc far
        
    Assume CS:Codigo,DS:Datos,SS:Pila
        
    mov ax,Datos ;ax=direccion del segmento de datos
        
    mov ds,ax ;ds=ax indicar el segmento de datos
        
    lea dx,Mensaje ;ds:dx=direccion del mensaje
        
    call Escribe ;Llamar al rpocedimiento Escribe
        
    mov ax,4c00h ;funcion para terminal el programa
        
    int 21h ;volver al DOS
        
holam3 endp
        
Escribe proc ;inicio procedimiento Escribe

    mov ah,9 ;funcion DOS para escribir texto en pantalla
    
    int 21h ;llamar a la interrupcion del DOS 
    
    ret ;volver o retornar
    
Escribe endp ;Fin del procedimiento Escribe

Codigo Ends

End holam3
