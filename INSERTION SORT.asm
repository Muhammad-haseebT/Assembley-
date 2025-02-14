.MODEL SMALL
.STACK 100H 
    P MACRO A
        PUSH AX
        PUSH DX
        
        MOV AH,9
        LEA DX,A
        INT 21H
        POP DX
        POP AX
    ENDM
    
        
.DATA
    AR DB 20 DUP(?)
    C DB 0
    A DB "ENTER VALUES : $"
    B DB 0AH,0DH,"SORTED ARRAY : $"
.CODE
MAIN PROC 
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    P A
    
    MOV CX,20
    LEA DI,AR
    MOV AH,1
INP:
    INT 21H
    CMP AL,13
    JE ENDI
    STOSB
    INC C
    LOOP INP 
ENDI:
    
    MOV AH,0
    LEA SI,AR
    MOV AL,C
    SUB AL,1
    LEA DI,AR 
    ADD DI, AX
    MOV CH,0 
    MOV CL,C
SORT:
    CALL MAX  
ABC:    
    MOV DL,[DI]
    XCHG DL,[BX]
    MOV [DI],DL
    DEC DI
    LOOP SORT 
    
    P B
    MOV CH,0
    LEA SI,AR
    MOV CL, C
    MOV AH,2 
DP:
    LODSB
    MOV DL,AL
    INT 21H
    LOOP DP     
    
    
    MOV AH,4CH
    INT 21H
    
    MAIN ENDP
MAX PROC
    PUSH CX
    PUSH AX
    XOR AX,AX
    LEA BX,AR
    MOV DL,[BX]
   
LP:    
    CMP [BX],DL
    JL NXT
    MOV DL,[BX]
    MOV AX,BX
NXT:
    INC BX        
    LOOP LP
    
    MOV BX,AX
    POP AX
    POP CX
     
    JMP ABC
    
    MAX ENDP

END MAIN