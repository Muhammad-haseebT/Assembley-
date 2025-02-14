.MODEL SMALL 
.STACK 100H
.DATA
    A DB "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz $"
    E DB 0AH,0DH,"ENTER INPUT : $"
    F DB 0AH,0DH,"ENTER KEY  : $" 
    C DB 0AH,0DH,"ENCRYPTED TEXT :  $"
    D DB 0AH,0DH,"DECRYPTED TEXT :  $"
    K DB ?
    L DB 53
    CC DW 0
    B DB 40 DUP(?)
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    MOV AH,9
    LEA DX, E
    INT 21H
    
    LEA DI, B
    MOV CX,40
    MOV AH,1
    CLD
INP:    
    INT 21H
    CMP AL,13
    JE END_INP
    STOSB
    INC CC
    LOOP INP 
END_INP: 
    
    MOV AH,9
    LEA DX, F
    INT 21H
    MOV AH,1
    INT 21H 
    SUB AL,48
    MOV K,AL   
    
    LEA SI,B
    MOV CX,CC
LP: 
    MOV AL,[SI]
    LEA DI,A
    CALL SEARCH 
ENDD:
    CALL INCRI 
    CMP DI,52
    JG MOD
AD:    
    MOV AL,[DI]
    MOV [SI],AL
    INC SI
    LOOP LP 
    
    MOV AH,9
    LEA DX,C
    INT 21H
    MOV CX,CC
    MOV AH,2
    LEA SI,B
DISP1: 
    
    MOV DL,[SI]
    INT 21H 
    INC SI
    LOOP DISP1
    
    
    XOR CX,CX
    LEA SI,B
    MOV CX,CC
LP1: 
    MOV AL,[SI]
    LEA DI,A
    CALL SEARCH 
ENDD1:
    CALL DECRI
AD1:    
    MOV AL,[DI]
    MOV [SI],AL
    INC SI
    LOOP LP1
    
    MOV AH,9
    LEA DX,D
    INT 21H
    LEA SI,B
    MOV AH,2
    MOV CX,CC
DISP:
    MOV DL,[SI]
    INT 21H  
    INC SI
    LOOP DISP
    JMP EXIT
MOD:
    XOR AX,AX 
    XOR DX,DX
    MOV AX,DI
    DIV L 
    MOV BL,AH
    XOR AX,AX 
    MOV AL,BL  
    MOV DI,AX
    JMP AD
EXIT:    
    MOV AH,4CH
    INT 21H
    MAIN ENDP 

SEARCH PROC
    PUSH CX
    XOR CX,CX
    MOV CX,53
C1:
     CMP AL,[DI]
     JE FO 
     INC DI
     LOOP C1 
     
FO:   
    POP CX
    RET
    SEARCH ENDP
INCRI PROC
    PUSH CX
    XOR CX,CX
    MOV CL,K
RP:
    INC DI
    LOOP RP
    POP CX
    RET
    INCRI ENDP 
DECRI PROC
    PUSH CX
    XOR CX,CX
    MOV CL,K
   RP1:
    DEC DI
    LOOP RP1
    POP CX
    JMP AD1
END MAIN