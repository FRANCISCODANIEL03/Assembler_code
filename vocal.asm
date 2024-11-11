.model small
.stack

.data
    cadena db "Murcielago$"
    num equ $-cadena; asigna a la variable el valor de cadena y no cambia en el programa
    tiene db 10,13, "tiene un total de vocales $"
    total db ?
.code
