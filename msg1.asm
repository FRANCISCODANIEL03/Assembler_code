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

ciclo:
    mov dl, msg[SI]
    cmp DL, 24h
    je ciclo1
    
    mov ah, 02
    mov dl, dl
    int 21h
    
    mov ah, 02
    mov dl, 0Ah
    int 21h
    
    inc SI
    jmp ciclo

ciclo1:
    mov dl, msg[SI]
    cmp DL, 0
    je fuera_ciclo
    
    mov ah, 02
    mov dl, dl
    int 21h
    
    mov ah, 02
    mov dl, 0Ah
    int 21h
    
    dec SI
    jmp ciclo1
    
fuera_ciclo:
    mov ax, 4c00h
    int 21h
end inicio
