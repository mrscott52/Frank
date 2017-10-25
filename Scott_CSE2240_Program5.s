;File Name: Scott_CSE2240_Program5 Author Name: Megan Scott Date: 4/16/17
;Purpose: To find all the prime numbers from 2 to 100
		GLOBAL Reset_Handler
		AREA 	Eratothenes, CODE, READONLY
		ENTRY

Reset_Handler

count	EQU	100 ;the highest possible prime number
store	EQU 0x40000000 ;the memory location for the primes
start	EQU 2 ;starting value
old		EQU 2 ;current number between 2 and 100
new		EQU 0	
	LDR r1, =count
	LDR r2, =store
	LDR r3, =start
	LDR r4, =old
	LDR r6, =new
	STRB r4, [r2]	
	ADD r2, #1
	
check
	LDR r3, =start
	MUL r6, r3, r4 ;multiply current value by p

	

prime
	ADD r4, r4, #1
	STRB r4, [r2]
	MOV r3, r4
	ADD r4, r3, #1
	ADD r2, r2, #1
	CMP r4,r6
	BEQ check
	LDR r3, =start
	ADD r3, r6, #1
	CMP r3,r6
	BGT check
	
stop B stop
	
	END
	