%include "io.inc"
section .data

REFERENCE times 20 db 0
READSTR times 20 db 0
READTMP times 20 db 0
POSITION times 20 db 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_STRING [REFERENCE], 20
    GET_STRING [READSTR], 20
    
    MOV EAX, [READSTR]
    MOV [READTMP], EAX
    MOV EAX, 0x00
    
    
    LEA ESI, [REFERENCE];POINTERS FOR TRAVERSING THE STRINGS
    LEA EDX, [READSTR]
    
    MOV BL, 1; FOR COUNTUNG LENGTH OF REFERENCE 
    MOV AL, 0; FOR COUNTING LENGTH OF READSTR
    
    COUNTREF:;COUNT LENGTH OF REFERENCE
            CMP byte[ESI], 0x00
            JE COUNTFINISH
            INC BL
            INC ESI
            JMP COUNTREF
            
    COUNTFINISH: 
            SUB BL, 2;STRING LENTH HAS TO SUBRTACT 2 TO BECOME MORE ACCURATE
            LEA ESI, [REFERENCE];RESETS POINTER
            
    COUNTREAD:
            CMP byte[EDX], 0x00;COUNTING LENGTH OF READ
            JE COUNTFINR
            INC AL
            INC EDX
            JMP COUNTREAD
            
    COUNTFINR:
            LEA EDX, [READSTR]
            
    ADD EDX, EAX
    LEA ECX, [READTMP]
    
    EQUALIZE:; TO MAKE REFERENCE AND READSTR EQUAL
            CMP AL, BL
            JE EQUALIZERFIN
            MOV BH, [ECX]
            MOV byte[EDX], BH
            INC EDX
            INC AL
            INC ECX
            CMP byte[ECX], 0x00
            JE RESET
            JMP EQUALIZE
    
    RESET:
            LEA ECX, [READTMP]
            JMP EQUALIZE
            
            
    EQUALIZERFIN:
            LEA ESI, [REFERENCE]
            LEA EDX, [READSTR]
            MOV EAX, 0
            MOV BL, 0;AMOUNT OF MISMATCH
    
    CHECK:;CHECKS IF MISMATCH OR NOT
            MOV AL, byte[EDX]
            CMP byte[ESI], AL
            JE CHARSAME
            JMP NOTSAMEONCE
            
    CHARSAME:
            INC ESI
            INC EDX
            JMP CHECK
            PRINT_STRING "HELLO WORLD"
            
    NOTSAMEONCE:;WHEN MISMATCH IS = 1 DO THIS
            INC BL
            CMP BL, 0x02
            JE NOTSAMETWICE
            INC ESI
            INC EDX
            JMP CHECK
            
    NOTSAMETWICE:; WHEN MISMATCH IS = 2 DO THIS
            
    
            
    
            
    
    
            
    
    
    
    
    xor eax, eax
    ret