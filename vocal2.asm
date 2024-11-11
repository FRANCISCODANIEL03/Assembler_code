.MODEL SMALL
.STACK 
.DATA
    PROMPT DB 'Ingrese una cadena: $'
    MSG_RESULT DB 'La cadena con mas vocales es: $'
    NL DB 13, 10, '$'

    CADENAS DB 5 DUP(30 DUP(?))  ; Espacio para 5 cadenas de hasta 30 caracteres
    MAX_VOCALES DB 0             ; Contador de vocales m?ximo
    MAX_INDEX DB 0               ; ?ndice de la cadena con m?s vocales

.CODE