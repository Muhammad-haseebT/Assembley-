.MODEL SMALL
 .STACK 100H
 .DATA
       A DB "DECIMAL OUTPUT  :   $"
       B DB "BINARY OUTPUT   ;   $"     
       C DB "HEXADECIMAL OUTPUT   ;   $"
       I DB 0AH,0DH,"INVALID  ENTER AGAIN   $",0AH,0DH  
       VALUE DB ?
       M DB 0AH,0DH,"ENTER 1 TO INPUT IN BINARY",0AH,0DH,"ENTER 2 TO INPUT IN DECIMAL",0AH,0DH,"ENTER 3 TO INPUT IN HEXADECIMAL",0AH,0DH,"$"
       SB  DB 0AH,0DH," BINARY CONVERSATION  ",0AH,0DH ,"$"
       SH  DB 0AH,0DH,"  HEXA CONVERSATION   ",0AH,0DH  ,"$"
       SD  DB 0AH,0DH,"   DECIMAL CONVERSATION  ",0AH,0DH,"$"
 .CODE                              
 
 MAIN PROC
    Mov AX, @DATA
    Mov DS, AX
     
       CALL MENU
       MOV AH,1
       INT 21H
       CMP AL,'1'
       JE BINARY
       CMP AL,'3'
       JE HEXA
       
    
       MOV AH,9
       LEA DX,SD
       INT 21H
    
    
        
       CALL DECIMALINPUT
       CALL DECIMALOUTPUT 
       JMP E
 BINARY: 
        MOV AH,9
        LEA DX,SB
        INT 21H
    
        CALL BINARYINPUT
        CALL DECIMALOUTPUT
        CALL HEXAOUTPUT
        CALL BINARYOUTPUT
        JMP E
 HEXA:   
         MOV AH,9
        LEA DX,SH
        INT 21H
    
        CALL HEXAINPUT
        CALL DECIMALOUTPUT
        CALL HEXAOUTPUT
        CALL BINARYOUTPUT
 E:
    MOV AH,4CH
    INT 21H
    MAIN ENDP
 
 
;******************************************************************************************************** 
HEXAOUTPUT PROC
    CALL NEWLINE
    PUSH AX 
    PUSH BX 
    PUSH CX
    PUSH DX
    
    PUSH AX
    PUSH DX
    
    MOV AH,9
    LEA DX,C
    INT 21H

    POP DX
    POP AX
    
    MOV CX, 4
    MOV AH, 2

PRINTH:
    MOV DL, BH
    
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    
    
    
    
    CMP DL,9
    JLE DISPNUMBER
    ADD DL,55
    JMP DISP
    
DISPNUMBER:
   ADD DL,48

DISP:
   INT 21H 
   
   ROL BX,1   
   ROL BX,1
   ROL BX,1
   ROL BX,1   
   
   LOOP PRINTH
   
       
    POP DX 
    POP CX
    POP BX
    POP AX 
     RET
 HEXAOUTPUT ENDP
;***********************************************************************************************
BINARYOUTPUT PROC 
CALL NEWLINE
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    
    PUSH AX
    PUSH DX
    
    MOV AH,9
    LEA DX,B
    INT 21H

    POP DX
    POP AX
    
      MOV CX,16
OUTPUT:
     
    MOV AH, 2
    
    SHL BX, 1
    
    JC IS1
    
    MOV DL, '0'
    INT 21H
    LOOP OUTPUT
    JMP EXITB
IS1:
    
    MOV DL, '1'
    INT 21H
    LOOP OUTPUT


EXITB: 
    POP DX 
    POP CX
    POP BX
    POP AX 
    RET      
BINARYOUTPUT ENDP   
;*************************************************************************************************************** 
DECIMALOUTPUT PROC
    CALL NEWLINE 
    PUSH AX
    PUSH DX
    MOV AH,9
    LEA DX,A
    INT 21H
    POP DX
    POP AX
     
    PUSH AX 
    PUSH BX 
    PUSH CX
    PUSH DX
      
    MOV AX, BX 
    XOR CX, CX 
    MOV BX, 10 
    
DECLOOP:
    XOR DX, DX 
    DIV BX 
    PUSH DX 
    INC CX  
    CMP AX, 0 
    JNE DECLOOP
    
    MOV AH, 2 
PRINT_DEC:
    POP DX
    ADD DL, 30H
    INT 21H
    LOOP PRINT_DEC  
    
    POP DX 
    POP CX
    POP BX
    POP AX
    RET
DECIMALOUTPUT ENDP
         
;**************************************************************************************************************   

HEXAINPUT PROC 
    
AG:      
    XOR BX,BX
    MOV CL,4
    MOV AH,1
INPUT:
    INT 21H
    CMP AL,13
    JE ENDINPUT 
    CMP AL,"F"
    JG INVALID
    
    SHL BX,CL
    CMP AL,'9'
    JLE NUMBER
    SUB AL,55
    JMP INSERT
    
NUMBER:
    SUB AL,48 
    
INSERT:
    OR BL,AL
    JMP INPUT  
INVALID: 
     PUSH AX
     PUSH DX
     
     MOV AH,9
      LEA DX,I
     INT 21H 
        
       POP DX
       POP AX
     JMP AG    
ENDINPUT:
      
    RET
   
HEXAINPUT ENDP 

;**********************************************************************************************************
BINARYINPUT PROC
 WAPIS:
    XOR BX,BX
    MOV CX, 16
    MOV AH, 1
    
INPUT1:

    INT 21H
    CMP AL, 13
    JE EX
    CMP AL,'0'
    JE SKIP
    CMP AL,'1'
    JNE GLAT
    
SKIP:  
    SHL BX, 1
    SUB AL, 48
    OR BL, AL
    JMP INPUT1 
GLAT:  
     PUSH AX
     PUSH DX
     
     MOV AH,9
      LEA DX,I
     INT 21H 
        
      POP DX
      POP AX 
      JMP WAPIS
EX:

       
RET   
BINARYINPUT ENDP

NEWLINE PROC
    PUSH AX
    PUSH DX
    
    MOV AH,2
    MOV DL,0Ah
    INT 21H
    MOV DL,0DH
    INT 21H
    
    POP DX
    POP AX 
    RET
    
    NEWLINE ENDP  

 ;****************************************************************************************************************
DECIMALINPUT PROC
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
     PUSH AX ;FOR HEXA JUGAR
     CMP CX,0
     JE EXIT
     
     NEG AX
     

     
NONDIGIT:
 
     MOV AH,2
     MOV DL,0DH
     INT 21H
     MOV DL ,0AH
     INT 21H
     JMP SHORO
 EXIT:
   
 
 ;BINARY OUTPUT 
      
    CALL NEWLINE 
    
    PUSH AX
    PUSH DX
    
    MOV AH,9
    LEA DX,B
    INT 21H
    
    POP DX
    POP AX 
    
      
    PUSH AX
    
    MOV BX,AX
    MOV CX,16
    MOV AH, 2  
 REPEATBd:
    ROL BX, 1
    JC PR_ONEd
    
    MOV DL, '0'
    INT 21H
    
    LOOP REPEATBd
    
    JMP EXIT1d
 PR_ONEd:
    MOV DL, '1'
    INT 21H
    
    LOOP REPEATBd  
    POP AX
EXIT1d:
 
; HEXA OUTPUT
    CALL NEWLINE
    PUSH AX
    PUSH DX

    MOV AH,9
    LEA DX,C
    INT 21H

    POP DX
    POP AX
    
    POP AX  ;FOR HEXA JUGAR
    MOV BX,AX
    MOV CX, 4
    MOV AH, 2

PRINTHd:
    MOV DL, BH
    
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    SHR DL, 1
    
    
    
    
    CMP DL,9
    JLE DISPNUMBERd
    ADD DL,55
    JMP DISPd
    
DISPNUMBERd:
   ADD DL,48

DISPd:
   INT 21H 
   
   ROL BX,1   
   ROL BX,1
   ROL BX,1
   ROL BX,1   
   
   LOOP PRINTHd
   RET

DECIMALINPUT ENDP
    
   
MENU PROC
    PUSH AX
    PUSH DX
    
    MOV AH,9
    LEA DX,M
    INT 21H
    
    
    POP DX
    POP AX 
    RET
   MENU ENDP

 END MAIN    
 \