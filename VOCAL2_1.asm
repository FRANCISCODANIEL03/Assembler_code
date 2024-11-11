.MODEL SMALL
.STACK

.DATA
    ; Definir las cadenas terminadas en '$'
    cadenas DB "Murcielago$", "Hola$", "TASM$", "Ensambladoraaaaa$", "Vocales$"
    num_cadenas EQU 5        ; Total de cadenas
    max_vocales DB 0         ; M?ximo de vocales encontradas
    max_indice DW 0          ; ?ndice de la cadena con m?s vocales (ahora es un word de 16 bits)
    vocales_cadenas DB 5 DUP(0)  ; Tabla para almacenar las vocales de cada cadena
    mensaje1 DB 10, 13, "La cadena con m?s vocales es: $"
    mensaje2 DB 10, 13, "Tiene un total de vocales: $"

.CODE
