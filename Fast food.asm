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
    A  DB  0AH,0DH,"ONLINE FOOD ORDER SYSTEM",0AH,0DH,"PRESS 1 TO ORDER PIZZA    ",0AH,0DH,"PRESS 2 TO ORDER BURGER       ",0AH,0DH,"PRESS 3 TO ORDER SANDWICH     ",0AH,0DH,"PRESS 4 TO ORDER HOT DOG      ",0AH,0DH,"PRESS 5 TO ORDER MUFFIN       ",0AH,0DH,"PRESS 6 TO ORDER LOADED FRIES ",0AH,0DH,"ORDER MORE THAN 5 ITEMS TO GET 20% DISCOUNT ",10,13,24H
    MP  DB 0AH,0DH,"PRESS 1 TO ORDER SMALL PIZZA ",0AH,0DH,    "PRESS 2 TO ORDER MEDIUM PIZZA ",0AH,0DH,"PRESS 3 TO ORDER LARGE PIZZA ",0AH,0DH,"PRESS 4 TO ORDER EXTRA LARGE PIZZA ",0AH,0DH,24H     
    MB  DB 0AH,0DH,"PRESS 1 TO ORDER CHICKEN  BURGER ",0AH,0DH, "PRESS 2 TO ORDER BEEF BURGER  ",0AH,0DH,24H 
    MS  DB 0AH,0DH,"PRESS 1 TO ORDER CLUB SANDWICH ",0AH,0DH,   "PRESS 2 TO ORDER SUB SANDWICH ",0AH,0DH,"PRESS 3 TO ORDER CHEESE SANDWICH ",0AH,0DH,24H
    MH  DB 0AH,0DH,"PRESS 1 TO ORDER CLASSIC HOT DOG ",0AH,0DH, "PRESS 2 TO ORDER CHILI HOT DOG ",0AH,0DH,24H
    MM  DB 0AH,0DH,"PRESS 1 TO ORDER BLUEBERRY MUFFIN ",0AH,0DH,"PRESS 2 TO ORDER CHOCLATE MUFFIN ",0AH,0DH,24H
    MF  DB 0AH,0DH,"PRESS 1 TO ORDER CHEESE FRIES ",0AH,0DH,"PRESS 2 TO ORDER CHILI FRIES ",0AH,0DH,24H
    MA  DB 0AH,0DH,"PRESS Y TO ORDER MORE... ",0AH,0DH,24H    
    MA1 DB 0AH,0DH,"PRESS Y TO CREATE NEW ORDER ... ",0AH,0DH,24H
    MA2 DB 0AH,0DH,"**********THANKS FOR ORDERING ENJOY YOUR MEAL********** $" 
    NMA DB 0AH,0DH,"ENTER YOUR NAME :  $"  
    NM1 DB 0AH,0DH,"CUSTOMER NAME  : $"
    NM2 DB 0AH,0DH,"********************",0AH,0DH,"         BILL    ",0AH,0DH,"********************$"
    I DB 0AH,0DH,"INVALID INPUT ENTER AGAIN $",0AH,0DH,24H
    P DW 0,300,900,1500,2200
    B DW 0,600,800
    S DW 0,450,650,400
    H DW 0,250,350
    M DW 0,200,150 
    F DW 0,250,350  
    NC DB 0
    PP  DB 0AH,0DH,"PIZZA                    $"
    PB  DB 0AH,0DH,"BURGER                   $"
    PS  DB 0AH,0DH,"SANDWICH                 $"
    PH  DB 0AH,0DH,"HOT DOG                  $"
    PM  DB 0AH,0DH,"MUFFIN                   $"
    PF  DB 0AH,0DH,"LOADED FRIES             $"
    PT  DB 0AH,0DH,"TOTAL                    $"
    PD  DB 0AH,0DH,"DISCOUNT PRICE           $"
    PDT DB 0AH,0DH,"TOTAL AFTER DISCOUNT     $"
    NAE DB 20 DUP(?) 
    CHK DW 20
    SUM DW 0 
    MU DB 2 
    C DB  0
    STO DB 30(?)      
         
.CODE 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    MOV ES, AX
    
    
     
AG2:          
    
    
    
    MOV CX,20
    LEA SI,NAE
RES:
    MOV [SI],32
    INC SI
    LOOP RES
    
    
    PRINT NMA
      
    LEA SI,NAE
    MOV CX,20
    MOV AH,1
RPP:
    INT 21H
    CMP AL,13
    JE ENDI
    
    MOV [SI],AL
    INC SI
    
    INC NC
    LOOP RPP
ENDI:        
    
    
    XOR BX,BX 
    LEA DI,STO
AGAIN:  
    
    
    
    XOR AX,AX 
       
    PRINT A
    
    MOV AH,1
    INT 21H
    
    SUB AL,48 
    
    
    CMP AL,1
    JE PIZZA
    CMP AL,2
    JE BURGER
    CMP AL,3
    JE SANDWICH
    CMP AL,4
    JE HOT_DOG
    CMP AL,5
    JE MUFFIN
    CMP AL,6
    JE FRIES
    
    PRINT I
    JMP AGAIN
PIZZA:
    MOV [DI],AL
    INC DI  
    
    PRINT MP
    
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE PIZ
    CMP AL,2
    JE PIZ
    CMP AL,3
    JE PIZ
    CMP AL,4
    JE PIZ
    
    DEC DI
    PRINT I
    JMP AGAIN
    
PIZ:
    MOV [DI],AL
    MOV BL,AL
    LEA SI,P 
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE
BURGER:
    MOV [DI],AL
    INC DI 
    
    PRINT MB
        
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE BUR
    CMP AL,2
    JE BUR 
   
    
    
    DEC DI
    
    PRINT I
    JMP AGAIN
BUR:
    MOV [DI],AL
    MOV BL,AL
    LEA SI,B
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE
SANDWICH:
    MOV [DI],AL
    INC DI 
    
    PRINT MS
    
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE SAN
    CMP AL,2
    JE SAN
    CMP AL,3
    JE SAN
    
    DEC DI
    
    PRINT I
    JMP AGAIN
SAN:  
    MOV [DI],AL
    MOV BL,AL
    LEA SI,S 
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE
     
HOT_DOG:
    MOV [DI],AL
    INC DI    
    
    PRINT MH
    
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE HOT
    CMP AL,2
    JE HOT
    
    DEC DI
    
    PRINT I
    
    JMP AGAIN
HOT:  
    MOV [DI],AL
    MOV BL,AL
    LEA SI,H
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX 
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE 
    
MUFFIN:
    MOV [DI],AL
    INC DI    
    
    PRINT MM
    
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE MUF
    CMP AL,2
    JE MUF
    
    DEC DI
    
    
    PRINT I
    
    JMP AGAIN
MUF: 
    MOV [DI],AL
    MOV BL,AL
    LEA SI,M
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE
    
FRIES: 
    MOV [DI],AL
    INC DI
       
    PRINT MF
    
    MOV AH,1
    INT 21H 
    
    SUB AL,48
    
    CMP AL,1
    JE FR
    CMP AL,2
    JE FR
    
    DEC DI
    
    
    PRINT I
    
    JMP AGAIN
FR:  
    MOV [DI],AL
    MOV BL,AL
    LEA SI,F
    MOV AX,2 
    MUL BX 
    MOV AH,0
    ADD SI,AX
    MOV BX,0
    MOV BX,SUM 
    ADD BX,[SI]
    MOV SUM,BX        
    JMP RE
    

  
  
RE: 
    INC C
    INC DI

    PRINT MA
    
    MOV AH,1
    INT 21H
    CMP AL,'Y'
    JE AGAIN
    CMP AL,'y'
    JE AGAIN
    
    PRINT NM2
    PRINT NM1
    
    PUSH CX
    LEA SI,NAE
    MOV AH,2
    MOV CH,0
    MOV CL,NC
    
DISPP:
    MOV DL,[SI]
    INC SI
    INT 21H
    
    LOOP DISPP
    POP CX
    
    
    XOR CX,CX
    MOV CL,C
     
    LEA DI,STO
     
     
DP:  
    XOR BX,BX 
    
    MOV AL,[DI]
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
    XOR AX,AX 
    
    PRINT PP
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,P
    ADD SI,BX
    MOV AX,[SI]
    
    CALL DECOUT 
    
    JMP DISPLAY
BU: 
    XOR AX,AX 
    
    PRINT PB
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,B
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    JMP DISPLAY
SA: 
    XOR AX,AX 
    
    PRINT PS 
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,S
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    JMP DISPLAY
HO: 
    XOR AX,AX 
    
    PRINT PH
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,H
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    JMP DISPLAY
MUU: 
    XOR AX,AX
     
    PRINT PM
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,M
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
    JMP DISPLAY
FRII: 
    XOR AX,AX 
    
    PRINT PF
    
    MOV AL,[DI]
    INC DI
    MUL MU
    MOV BL,AL
    LEA SI,F
    ADD SI,BX
    MOV AX,[SI]
    CALL DECOUT
DISPLAY:    
    LOOP DP
       
    
    
        
    PRINT PT
    
    MOV AX,SUM
    CALL DECOUT
    
    CMP C,5
    JL EX
    
    PRINT PD
    
    MOV AX,SUM
    MUL CHK
    MOV CX,100
    DIV CX
    CALL DECOUT
    
    MOV BX,AX
    
    PRINT PDT
    
    MOV AX,SUM
    
    SUB AX,BX
    CALL DECOUT
EX:    
    PRINT MA1
    
    MOV AH,1
    INT 21H
    CMP AL,'Y'
    JE AG2
    CMP AL,'y'
    JE AG2
    
    MOV AH,4CH 
    INT 21H
    MAIN ENDP
     
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
