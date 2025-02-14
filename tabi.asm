.MODEL SMALL
.STACK 100H   
    PRINT MACRO A
        PUSH AX
        PUSH DX
        MOV AH,9
        LEA DX,A
        INT 21H
        POP DX
        POP AX
    ENDM 
    
.DATA
    A DB 10,13,"ENTER FIRST  VALUE : $"
    B DB 10,13,"ENTER SECOND VALUE : $"
    C DB 10,13,"ENTER OPERATOR     : $"
    D DB 10,13,"ANSWER =  $"
    E DB 10,13,"INVALID INPUT ENTER AGAIN  $ "
    F DB 10,13,"PRESS Y TO ENTER AGAIN $" 
    NAE DB 20 DUP(?) 
    NC DB 0
    NMA DB 0AH,0DH,"ENTER YOUR NAME :  $" 
    MA2 DB 0AH,0DH,"********** THANKS $"
    MA1 DB " FOR USING OUR SERVICE ********** $"  
.CODE
MAIN PROC
    MOV AX,@DATA
    MOV DS,AX
    MOV ES,AX
    
    
    PRINT NMA
      
    LEA SI,NAE
    MOV CX,20
    MOV AH,1
RPP:
    INT 21H
    CMP AL,13
    JE AGAIN
    
    MOV [SI],AL
    INC SI
    
    INC NC
    LOOP RPP
      
AGAIN:    


    
    MOV AH,9
    LEA DX,A
    INT 21H
    CALL DECIN
    
    MOV BX,AX
    
    MOV AH,9
    LEA DX,B
    INT 21H
    
    CALL DECIN
    
    MOV CX,AX
    
    MOV AH,9
    LEA DX,C
    INT 21H
    
    MOV AH,1
    INT 21H
    
    
    CMP AL,'+'
    JE AD
    CMP AL,'-'
    JE MI
    CMP AL,'*'
    JE MU
    CMP AL,'/'
    JE DIVI 
    CMP AL,'%'
    JE MOD
    
    MOV AH,9
    LEA DX,E
    INT 21H
    
    JMP AGAIN
AD:
    ADD BX,CX
    MOV AX,BX
    JMP DP
MI:
    SUB BX,CX
    MOV AX,BX
    JMP DP
MU: 
    MOV AX,BX
    MUL CX
    JMP DP    
DIVI:
    XOR DX,DX
    MOV AX,BX
    DIV CX
    JMP DP
MOD:
    XOR DX,DX
    MOV AX,BX
    DIV CX
    MOV AX,DX
    
DP: 
    PUSH AX
    MOV AH,9
    LEA DX, D
    INT 21H
    POP AX
    CALL DECOUT
    
    MOV AH,9
    LEA DX, F
    INT 21H 
    
    MOV AH,1
    INT 21H
    
    CMP AL,'Y'
    JE AGAIN
    CMP AL,'y'
    JE AGAIN
    
    PRINT MA2
    
    LEA SI,NAE
    MOV AH,2
    MOV CH,0
    MOV CL,NC
    
DISPP:
    MOV DL,[SI]
    INC SI
    INT 21H
    
    LOOP DISPP
    PRINT MA1       
    
    MOV AH,4CH
    INT 21H
    MAIN ENDP
DECIN PROC
    
    PUSH BX
    PUSH CX
    PUSH DX
SHORO:    
    XOR CX,CX
    XOR BX,BX
    
    MOV AH,1
    INT 21H
    
    CMP AL,"-"
    JE NEGA
    CMP AL,"+"
    JE POS
    JMP REPEAT
    
 NEGA:
    MOV CX,1
 POS:
     INT 21H
 REPEAT:
     CMP AL,"0"
     JL NONDIGIT
     CMP AL,"9" 
     JG NONDIGIT
     
     AND AX,000FH
     PUSH AX
     
     MOV AX,10
     MUL BX
     
     POP BX
     ADD BX,AX
     
     MOV AH,1
     INT 21H
     
     CMP AL,0DH
     JNE REPEAT
     
     MOV AX,BX
     CMP CX,0
     JE EXIT
     
     NEG AX
     
EXIT:
     POP DX
     POP CX
     POP BX
     RET
     
NONDIGIT:
 
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL ,0AH
     INT 21H
     JMP SHORO 
     RET
              
    DECIN ENDP 
          
   
DECOUT PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
              
    CMP AX,0
    JG ALPHA
    
    PUSH AX 
    
    MOV DL,"-"
    MOV AH,2
    INT 21H
    
    POP AX
    NEG AX
ALPHA:
    XOR CX,CX
    MOV BX,10
    
WHILE:
    XOR DX,DX
    DIV BX
    PUSH DX
    
    INC CX
    
    CMP AX,0
    JNE WHILE
    
    MOV AH,2
PRINT:
    POP DX
    ADD DL,30H
    INT 21H
    LOOP PRINT
    
    POP DX
    POP CX
    POP BX
    POP AX
    
    RET
    DECOUT ENDP
END MAIN