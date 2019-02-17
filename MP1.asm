%include "io.inc"
section .data

REFERENCE times 20 db 0
READSTR times 20 db 0
POSITION times 20 db 0
TEMP times 20 db 0
COUNT db 0x00
READLEN db 0x00
POSADD dw 0x00000000
POSLOC db 0x00

section .text
global CMAIN
CMAIN:
    mov ebp, esp; for correct debugging
    ;write your code here
    GET_STRING [REFERENCE], 20
    GET_STRING [READSTR], 20
    
    LEA ESI, [REFERENCE];POINTERS FOR TRAVERSING THE STRINGS
    LEA EDX, [READSTR]
    
    LEA EDI, [POSITION]
    MOV dword[POSADD], EDI
    
    MOV AL, 0; FOR COUNTING LENGTH OF READSTR
            
    COUNTREAD:;COUNTING OF LENGTH OF READ
            CMP byte[EDX], 0x00
            JE COUNTFINR
            INC AL
            INC EDX
            JMP COUNTREAD
            
    COUNTFINR:
            LEA EDX, [READSTR]
            LEA EDI, [TEMP]
            
    MOV ECX, EAX
    MOV byte[READLEN], CL
    MOV byte[POSLOC], 0x00
    PRINT_STRING "POSITION:"
    JMP FIRSTSET
    
   
    NEXTSET:
        INC byte[POSLOC]
        FIRSTSET:
        MOV EAX, 0
        L1:; PUT 4 CHARACTERS TO TEMP
            CMP byte[ESI+EAX], 0x00
            JE OUTPUT
            MOV BH, byte[ESI + EAX]
            MOV [EDI], BH
            INC EAX
            INC EDI
            LOOP L1
            
    LEA EDI, [TEMP]; TO RESET TEMP
    MOV AH, 0; TO CHECK FOR HAMMING DISTANCE
    ;EDX = READSTR
    
   
    
    CHECK:
            CMP byte[EDI], 0x00
            JE FOUNDPOS
            MOV BL, byte[EDI]
            CMP byte[EDX], BL
            JNE NOTEQUAL
            INC EDX
            INC EDI
            JMP CHECK
            
    NOTEQUAL:
            INC AH
            CMP AH, 0x02
            JG DNF
            INC EDX
            INC EDI
            JMP CHECK
            
    DNF:
            LEA EDI, [TEMP]
            LEA EDX, [READSTR]
            MOV cl, byte[READLEN] 
            INC ESI
            JMP NEXTSET
            
            
    FOUNDPOS: 
            ;PRINT_STRING "WOAH I MADE IT"
            INC byte[COUNT]
            PRINT_UDEC 1, [POSLOC]
            PRINT_CHAR ','
            LEA EDI, [TEMP]
            LEA EDX, [READSTR]
            MOV CL, byte[READLEN]
            INC ESI
            JMP NEXTSET
    
         
    OUTPUT:
            NEWLINE
            PRINT_STRING "COUNT: "
            PRINT_UDEC 1, [COUNT]
            
            
            
    
            
    
    
    
    
    xor eax, eax
    ret