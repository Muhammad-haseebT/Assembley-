.MODEL SMALL 
.STACK 100H
.DATA 
    A DB   0AH,0DH,"*THANK YOU FOR VISITING IN",0AH,0DH,0AH,0DH,"ONLINE MEDICINE ORDER SYSTEM*",,0AH,0DH,0AH,0DH,"ENTER 1 TO ORDER PANADOL    ",0AH,0DH,"ENTER 2 TO ORDER BRUFEN       ",0AH,0DH,"ENTER 3 TO ORDER SOFVASIC D     ",0AH,0DH,"ENTER 4 TO ORDER VIBRAMYCIN      ",0AH,0DH,"ENTER 5 TO ORDER CALPOL SYRUP       ",0AH,0DH,"ENTER 6 TO ORDER DISPRINE ",0AH,0DH,24H
    MA DB 0AH,0DH,"PRESS Y TO ORDER MORE... ",0AH,0DH,24H
    I DB 0AH,0DH,"INVALID INPUT ENTER AGAIN $",0AH,0DH,24H 
    QT DB 10,13,"ENTER QTY : $"
    P DW 0,50,250,300,300,400,30
    PP DB 0AH,0DH,"PANADOL          $"
    PB DB 0AH,0DH,"BRUFFIN          $"
    PS DB 0AH,0DH,"SOFVASIC D       $"
    PH DB 0AH,0DH,"VIBRAMYSIN       $"
    PM DB 0AH,0DH,"CALPOL SYRUP     $"
    PF DB 0AH,0DH,"DISPRINE         $"
    PT DB 0AH,0DH,"TOTAL            $"
    CHK DW 300
    SUM DW 0 
    MU DB 2 
    C DB  0
    QTY DB 0
    STO DB 30 DUP(?)     
         
.CODE 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    MOV ES, AX
    
    XOR BX,BX 
    LEA DI,STO
AGAIN:
    XOR AX,AX    
    MOV AH,9
    LEA DX, A
    INT 21H
    
    MOV AH,1
    INT 21H
    
    SUB AL,48 
    
    
    PUSH AX
    
    MOV AH,9
    LEA DX,QT  
    INT 21H
    CALL DECIN
    MOV QTY,AL
    
    
    POP AX
    
    
    CMP AL,1
    JE PA
    CMP AL,2
    JE BR
    CMP AL,3
    JE SO
    CMP AL,4
    JE CA
    CMP AL,5
    JE VI
    CMP AL,6
    JE DIS
    
    LEA DX,I
    INT 21H
    JMP AGAIN
PA:  
    
    MOV [DI],AL
    INC DI
      
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    MOV BL,AL
    LEA SI,P
     
    MOV AX,2
     
    MUL BX 
    
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX 
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE
BR:
    MOV [DI],AL 
    
    INC DI 
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    
    MOV BL,AL
    LEA SI,P
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    
    
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX  
    
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE
SO:
    MOV [DI],AL 
    INC DI
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    
    MOV BL,AL
    LEA SI,P 
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    
    
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX  
     
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE
     
CA:
    MOV [DI],AL
    INC DI
     
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    
    MOV BL,AL
    LEA SI,P
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX 
    MOV BX,0
    MOV BX,SUM 
    
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX 
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE 
    
VI:
    MOV [DI],AL
    INC DI
    
      
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    
    MOV BL,AL
    LEA SI,P
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
  
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX  
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE
    
DIS: 
    MOV [DI],AL
    INC DI
      
    PUSH AX
    XOR AX,AX
    MOV AL,QTY
    MOV [DI],AL
    POP AX 
    
    
    MOV BL,AL
    LEA SI,P
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
   
   
    XOR AX,AX
    MOV AX,[SI]
    MOV CH,0
    MOV CL,QTY
    MUL CX  
    
    
    ADD BX,AX 
    
    MOV SUM,BX        
    JMP RE
    

  
  
RE: 
    INC C
    INC DI

    MOV AH,9
    LEA DX,MA
    INT 21H
    
    MOV AH,1
    INT 21H
    CMP AL,'Y'
    JE AGAIN
    CMP AL,'y'
    JE AGAIN
    XOR CX,CX
    MOV CL,C 
    LEA DI,STO
   
DP: 
    XOR AX,AX 
    XOR BX,BX
    MOV AL,[DI]
    MOV BL,AL
    INC DI
    
    CMP AL,1
    JE PI
    CMP AL,2
    JE BU
    CMP AL,3
    JE SA
    CMP AL,4
    JE HO
    CMP AL,5
    JE MUU
    CMP AL,6
    JE FRII
    JMP DISPLAY
PI: 
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    MOV AH,9
    LEA DX,PP
    INT 21H
   
    PUSH AX
    MOV AH,0
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL
    CALL DECOUT
    POP AX
    CALL SPACE
    MOV AL,BL
    
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    CALL SPACE
    MUL CL
    CALL DECOUT
    
    POP CX
    
    JMP DISPLAY
BU:  
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    MOV AH,9
    LEA DX,PB
    INT 21H
    
    PUSH AX
    MOV AH,0
    
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL
    
    CALL DECOUT
    POP AX
    CALL SPACE
    
    MOV AL,BL
    
    
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT 
    
    CALL SPACE 
    
    XOR BX,BX
    MOV BL,CL
    MUL BX
    
    
    CALL DECOUT
    POP CX
    JMP DISPLAY
SA:  
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    MOV AH,9
    LEA DX,PS
    INT 21H
    
    PUSH AX
    MOV AH,0
    
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL
    
    CALL DECOUT
    POP AX
    CALL SPACE
    
    MOV AL,BL
    
    
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    
    CALL SPACE 
    
    XOR BX,BX
    MOV BL,CL
    MUL BX
    
    
    CALL DECOUT
    POP CX
    JMP DISPLAY
HO: 
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    MOV AH,9
    LEA DX,PH
    INT 21H
    
    
    PUSH AX
    MOV AH,0
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL
    
    CALL DECOUT
    POP AX
    CALL SPACE
    
    MOV AL,BL
    
    
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
   
    CALL SPACE
     
    XOR BX,BX
    MOV BL,CL
    MUL BX
    CALL DECOUT
    POP CX
    JMP DISPLAY
MUU: 
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    MOV AH,9
    LEA DX,PM
    INT 21H
    
    
    PUSH AX
    MOV AH,0
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL
    
    CALL DECOUT
    POP AX
    CALL SPACE
    
    MOV AL,BL
    
    
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
   
    CALL SPACE 
    
    XOR BX,BX
    MOV BL,CL
    MUL BX
    
    CALL DECOUT
    POP CX
    JMP DISPLAY
FRII: 
    PUSH CX 
    XOR CX,CX
    XOR AX,AX 
    
    MOV AH,9
    LEA DX,PF
    INT 21H
    
   
    PUSH AX
    MOV AH,0
    
    MOV AL,[DI]
    INC DI
    MOV CL,AL 
    
    CALL DECOUT
    POP AX
    
    CALL SPACE
    
    MOV AL,BL
    
    
    MUL MU
    
  
    
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    
    CALL DECOUT
    CALL SPACE 
    
    XOR BX,BX
    MOV BL,CL
    MUL BX
    
    CALL DECOUT
    POP CX
    
DISPLAY:    
    LOOP DP
       
    
        
    MOV AH,9
    LEA DX,PT
    INT 21H
    MOV AX,SUM
    CALL DECOUT
    
    
    MOV AH,4CH 
    INT 21H
    MAIN ENDP 
SPACE PROC
    PUSH AX
    PUSH CX
    PUSH DX
    PUSH BX
    
    MOV AH,2
    MOV DL,32
    INT 21H
    
    MOV DL,32
    INT 21H
    
    POP BX
    POP DX
    POP CX
    POP AX
    RET
    SPACE ENDP

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
    
END MAIN
