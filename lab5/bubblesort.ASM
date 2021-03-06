.model small
DISPLAY MACRO MSG
LEA DX,MSG
MOV AH,09H
INT 21H
ENDM


.DATA
N DB 5
LIST DB 02H,01H,34H,0F4H,09H,05H
MSG1 DB 0DH,0AH, "1>>ASCENDING ORDER"
MSG2 DB 0DH,0AH, "2>>DESCENDING ORDER"
MSG3 DB 0DH,0AH, "3:EXIT"
MSG4 DB 0DH,0AH, "Enter your choice ::$"
MSG5 DB 0DH,0AH, "INVALID CHOICE ENTERED ..$"

.CODE
MOV AX,@DATA
MOV DS,AX
MOV CL,N
DEC CL
DISPLAY MSG1
DISPLAY MSG2
DISPLAY MSG3
DISPLAY MSG4
MOV AH,01H
INT 21H
SUB AL,30H
CMP AL,01H
JE AS
CMP AL,02H
JE DES
CMP AL,03H
JE FINAL


AS:
  OUTLOOP1: MOV CH,CL
           MOV SI,00H

  INLOOP1: MOV AL,LIST[SI]
          INC SI
          CMP AL,LIST[SI]
          JC NO_EXCHG1
          XCHG AL,LIST[SI]
          MOV  LIST[SI-1],AL

  NO_EXCHG1: DEC CH
             JNZ INLOOP1
             DEC CL
             JNZ OUTLOOP1
             MOV AH,4CH
             INT 21H


       
DES:
   OUTLOOP2: MOV CH,CL
             MOV SI,00H

   INLOOP2:  MOV AL,LIST[SI]
            INC SI
            CMP AL,LIST[SI]
            JNC NO_EXCHG2
            XCHG AL,LIST[SI]
            MOV LIST[SI-1],AL

   NO_EXCHG2: DEC CH
             JNZ INLOOP2
             DEC CL
             JNZ OUTLOOP2
             MOV AH,4CH
             INT 21H

FINAL:  MOV AH,4CH
        INT 21H

END
