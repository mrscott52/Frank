RCC_APB2ENR	EQU 0x40021018
GPIOE_CRH 	EQU 0x40011804
GPIOE_BSRR	EQU	0x40011810
GPIOE_CRL	EQU 0x40011000
ADC1_SQR1	EQU 0x4001242C
ADC1_SQR2	EQU 0x40012430
ADC1_SQR3	EQU 0x40012434
ADC1_SMPR1	EQU 0x4001240C
ADC1_SMPR2	EQU 0x40012410
ADC1_CR1	EQU 0x40012404
ADC1_CR2	EQU 0x40012408
ADC1_SR		EQU 0x40012400
ADC1_DR		EQU 0x4001244C

	GLOBAL Reset_Handler
		

	AREA	Lab5, CODE, READONLY
	ENTRY
Reset_Handler
;#include <stm32f10x_cl.h>
;#define LED_NUM 8 /* Number of user LEDs */
;const long led_mask[] = { 1<<15, 1<<14, 1<<13, 1<<12, 1<<11, 1<<10, 1<<9, 1<<8 };
;int main (void) {
;int AD_val, i;
;int num = -1;
;int dir = 1;
;SystemInit()8;
;/* Setup GPIO for LEDs */
;RCC->APB2ENR |= 1 << 6; /* Enable GPIOE clock */
	LDR r0, =RCC_APB2ENR
	LDR R1, =GPIOE_CRH
	LDR R2, =GPIOE_BSRR
	
	LDR R3, [R0]
	MOV R4, #1
	LSL R4, R4, #6
	ORR R3, R3, R4
	STR R3, [R0]
;GPIOE->CRH = 0x33333333; /* Configure the GPIO for LEDs */
	LDR R3, =0X33333333
	STR R3, [R1]
;/* Setup and initialize ADC converter */
;RCC->APB2ENR |= 1 << 9; /* Enable ADC1 clock */
	LDR R3, [R0]
	MOV R4, #1
	LSL R4, R4, #9
	ORR R3, R3, R4
	STR R3, [R0]
;GPIOC->CRL &= 0xFFF0FFFF; /* Configure PC4 as ADC.14 input */
	LDR R0, =GPIOE_CRL
	LDR R1, [R0]
	LDR R3, =0xFFF0FFFF
	AND	R1, R1, R3
	STR R1, [R0]
;ADC1->SQR1 = 0x00000000; /* Regular channel 1 conversion */
;ADC1->SQR2 = 0x00000000; /* Clear register */
;ADC1->SQR3 = 14 << 0; /* SQ1 = channel 14 */
	MOV R3, #0X00000000
	LDR R0, =ADC1_SQR1
	STR R3,[R0]
	LDR R0, =ADC1_SQR2
	STR R3,[R0]
	LDR R3, =14
	LSL R3, R3, #0
	LDR R0, = ADC1_SQR3
	STR R3, [R0]
	
;ADC1->SMPR1 = 5 << 12; /* Channel 14 sample time is 55.5 cyc */
;ADC1->SMPR2 = 0x00000000; /* Clear register */
	LDR r0, =ADC1_SMPR1
	MOV R3, #5
	LSL R3, R3, #12
	STR R3, [R0]
	LDR R0, =ADC1_SMPR2
	MOV R3, #0X0000000
	STR R3, [R0]

;ADC1->CR1 = 1 << 8; /* Scan mode on */
	LDR r0, =ADC1_CR1
	MOV R3, #1
	LSL R3, R3, #8
	STR R3, [R0]
;ADC1->CR2 = (1 << 20) | /* Enable external trigger */
;(7 << 17) | /* EXTSEL = SWSTART */
;(1 << 1) | /* Continuous conversion */
;(1 << 0) ; /* ADC enable */
	LDR R0, = ADC1_CR2
	MOV R3, #1
	LSL R3, R3, #20
	MOV R4, #7
	LSL R4, R4, #17
	ORR R3, R3, R4
	MOV R4, #1
	LSL R4, R4, #1
	ORR R3, R3, R4
	MOV R4, #1 
	LSL R4, R4, #0
	ORR R3, R3, R4
	STR R3, [R0]
;ADC1->CR2 |= 1 << 3; /* Initialize calibration registers */
	LDR r0, =ADC1_CR2
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #3
	ORR R1, R1, R3
	STR R3, [R0]
;while (ADC1->CR2 & (1 << 3)); /* Wait for initialization to finish */
while1
	LDR R0, =ADC1_CR2
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #3
	AND R1, R1, R3
	CMP R1, #1
	BEQ while1
;ADC1->CR2 |= 1 << 2; /* Start calibration */
	LDR r0, =ADC1_CR2
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #2
	ORR R1, R1, R3
	STR R3, [R0]
;while (ADC1->CR2 & (1 << 2)); /* Wait for calibration to finish */	
while2 
	LDR R0, =ADC1_CR2
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #2
	AND R1, R1, R3
	CMP r1, #1
	BEQ while2
	
;ADC1->CR2 |= 1 << 22; /* Start first conversion */
	LDR r0, =ADC1_CR2
	LDR R4, [R0]
	MOV R3, #1
	LSL R3, R3, #22
	ORR R4, R4, R3
	STR R4, [R0]
;for (;;) { /* Loop forever */
;if (ADC1->SR & (1 << 1)) { /* If conversion has finished */
;AD_val = ADC1->DR & 0x0FFF; /* Read AD converted value */
;ADC1->CR2 |= 1 << 22; /* Start new conversion */
mainLoop
ADCConversion
	LDR R0, =ADC1_SR
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #1
	AND R1, R1, R3
	CMP R1, #2
	BNE ADCConversion
	
	LDR R0, =ADC1_DR
	LDR R1, [R0]
	LDR R3, =0X0FFF
	AND R1, R1, R3
	LSL R1, R1, #8
	
	LDR R0, =ADC1_CR1
	LDR R1, [R0]
	MOV R3, #1
	LSL R3, R3, #22
	ORR R1, R1, R3
	STR R1, [R0]
	
	

	;load number in register 0x100
	LDR r5, =0x100
	MOV r6, #8
	;use counter value 
TurnOn
	STR r5, [r2]
	MOV r4, r1
delayOne
	SUB	r4, r4, #1
	CMP r4, #0
	BNE	delayOne
	LSL	r5, #1
	SUB r6, r6, #1
	CMP r5, #0
	BNE TurnOn
	MOV r1, r4
	
mainDelay
	SUB	r4, #1
	CMP r4, #0
	BNE mainDelay
	MOV r7, #0x10000000
	MOV r6,#8

TurnOff
	STR r7, [r2]
	MOV r4, r1
	
delayOn
	SUB	r4, #1
	CMP r4, #0
	BNE	delayOn
	LSL	r7, #1
	SUB r6, #1
	CMP r6, #0
	BNE TurnOff

		
	END
	
;}
;/* Calculate 'num': 0, 1, ... , LED_NUM-1, LED_NUM-1, ... , 1, 0, 0, ... */
;num += dir;
;if (num >= LED_NUM) { dir = -1; num = LED_NUM-1; }
;else if (num < 0) { dir = 1; num = 0; }
;GPIOE->BSRR = led_mask[num]; /* Turn LED on */
;for (i = 0; i < ((AD_val << 8) + 100000); i++);
;GPIOE->BSRR = led_mask[num] << 16; /* Turn LED off */
;}
;}

