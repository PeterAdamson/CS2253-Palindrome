START
	LDR	R13,=0xFF000000
	MOV	R3,#1
	MOV	R6,#0
	LDR	R1,=ST1			;Start of the string
	LDR	R2,=(ST1END - 2)	;End of the string
	BL	PALIN
	CMP	R0,#1
	STREQ	R3,=FLAG1
	STRNE	R6,=FLAG1
;test with the next string
	LDR	R1,=ST2		        ;Start of the string
	LDR	R2,=(ST2END - 2)	;End of the string
	BL	PALIN
	CMP	R0,#1
	STREQ	R3,=FLAG2
	STRNE	R6,=FLAG2
	LDR	R4,=FLAG1
	LDR	R5,=FLAG2
STOP	B	STOP
PALIN
	STMDB	R13!,{R1-R6,LR}
	CMP	R1,R2 			;if the location of the start and end of the string are the same (e.g an empty string), it is a palindrome
	MOVGE	R0,#1
	MOVGE	PC,LR
	LDRB	R4,[R1],#1
	LDRB	R5,[R2],#-1
	CMP	R4,R5
	MOVNE	R0,#0
	MOVNE	PC,LR
	BL	PALIN
	LDMIA	R13!,{R1-R6,PC}

FLAG1	DCD	0
FLAG2	DCD	0
ST1	DCB	'racecar',0
ST1END
ST2	DCB	'mytestym',0
ST2END
	ALIGN	4
