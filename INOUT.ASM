DECIN PROC
    PUSH BX
    PUSH CX
    PUSH DX
BEGIN:    
    XOR BX,BX
    XOR CX,CX
    
    MOV AH,1
    INT 21H
    
    CMP AL, '-'
    JE MINUS
    CMP AL,'+'
    JE PLUS
    JMP REPEAT
MINUS:
    MOV CX,1
PLUS:
    INT 21H
REPEAT:
    CMP AL,'0'
    JL NO
    CMP AL,'9'
    JG NO
    
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
NO:
    CALL NEWL
    JMP BEGIN    
    DECIN ENDP      
DECOUT PROC
    PUSH DX
    PUSH BX
    PUSH CX
    PUSH AX
    
    CMP AX, 0
    JG ALPHA
    
    PUSH AX
    
    MOV AH, 2
    MOV DL,'-'
    INT 21H
    
    POP AX
    NEG AX
    
ALPHA:    
    XOR CX,CX
    MOV BX,10
WHILE:    
    XOR DX,DX
    DIV BX
    INC CX
    PUSH DX
    
    CMP AX,0
    JNE WHILE
    MOV AH,2
PRINT:
    POP DX
    ADD DX,30H
    INT 21H
    LOOP PRINT   
    
    
    POP AX
    POP CX
    POP BX
    POP DX
    RET
    DECOUT ENDP
NEWL PROC
    PUSH AX
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    POP AX
    RET
    NEWL ENDP 