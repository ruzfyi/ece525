	.arch armv8-a 		// expected ISA to use for the program
	.file	"P1-1.c" 	// metadata keeping track of the original file that is being compiled
	.text				// declares to switch to the code segment for the actual instructions, this is always the first instruction

// this portion at the top is declaring all of the variables that are declared on the c file prior to the program loop just like the original C file is set up

// declares var1
	.global	var1		// defines and exports var1
	.data				// switch to the data segment of memory to store variable
	.type	var1, %object	// mark var1 as a data object
	.size	var1, 1			// set 1 byte for the signed character, same as an unsigned one
var1:					// mark a symbolic address in memory for var1
	.byte	1			// assign the value of 1 in a byte var1

// declares var2
	.global	var2		// declare var2
	.type	var2, %object	// set var2 as data
	.size	var2, 1		// mark var2 as one byte
var2:					// mark the symbolic address of var2
	.byte	2			// assign the value of 2 in a byte for var2

// declares var3
	.global	var3		// declare var3
	.align	2			// align the memory location to a 4 byte boundary
	.type	var3, %object	// set var3 as data type
	.size	var3, 4		// mark 4 bytes of length for var3 which is how many bytes are needed for a signed int
var3:					// mark the symbolic address of var3
	.word	3			// assign the value of 3 of a size of word to var3

// declares var4
	.global	var4		// define the var4 variable
	.align	2			// ensure that the location is aligned on a 4 byte boundary
	.type	var4, %object	// set var4 as a data object type
	.size	var4, 4		// mark 4 bytes for var4
var4:					// mark the symbolic memory location for var4
	.word	4			// set the value 4 of word size

// declares num variable
	.global	num			// define the num variable
	.section	.rodata	// switch to the read only data segment since num is a constant
	.align	2			// ensure that the location is aligned on a 4 byte boundary
	.type	num, %object	// mark num as a data type
	.size	num, 4		// mark 4 byte size for num
num:					// mark the symbolic location for num
	.word	-10			// set the number -10 in num of word size

// declares the wave array
	.global	wave		// define the wave variable
	.data				// switch to the data segment
	.align	3			// align the wave array on an 8 byte boundary
	.type	wave, %object	// set wave as a data type
	.size	wave, 10	// reserve 10 bytes for wave
wave:					// mark the symbolic memory location for wave
	.string	"goodbye!!"	// initialize the string into wave

// from this point on is the executable program
	.text				// switch to the code segment where the program will be executed from
	.align	2			// ensure that the program is started at a 4 byte boundary
	.global	main		// declare the main section function
	.type	main, %function		// mark the main section as a function type
main:					// mark the symbolic memory location for the main loop and where the program should start from
.LFB0:					// Local Function Begninning 0 defining for the linker that this is a private function, is the beginning and is the first function
	.cfi_startproc		// begin tracking program trace here
	sub	sp, sp, #16		// initialize the stack pointer by reserving 16 bytes because the stack pointer is counted backwards
	.cfi_def_cfa_offset 16	// update the stack tracker that the stack pointer has been offset
	mov	w0, 5			// store the value 5 for var5 that is the loop counter
	str	w0, [sp, 12]	// store the value of var 5 12 bytes higer than the stack pointer
	b	.L2				// branch to L2 the for loop condition

// for loop body
.L3:
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	ldrsb	w0, [x0]
	and	w1, w0, 255
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	ldrsb	w0, [x0]
	and	w0, w0, 255
	mul	w0, w1, w0
	and	w0, w0, 255
	sxtb	w1, w0
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	strb	w1, [x0]
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	mov	w1, 1
	strb	w1, [x0]
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	ldrsb	w0, [x0]
	and	w0, w0, 255
	ubfiz	w0, w0, 1, 7
	and	w0, w0, 255
	sxtb	w1, w0
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	strb	w1, [x0]
	adrp	x0, var1
	add	x0, x0, :lo12:var1
	strb	wzr, [x0]
	ldr	w0, [sp, 12]
	sub	w0, w0, #1
	str	w0, [sp, 12]

// for loop condition
.L2:
	ldr	w0, [sp, 12]	// get the current value of var5 from the stack
	cmp	w0, 0			// is var5 greater than 0? 
	bgt	.L3		// 

.L4:
	adrp	x0, var4
	add	x0, x0, :lo12:var4
	ldr	w0, [x0]
	sub	w1, w0, #1
	adrp	x0, var4
	add	x0, x0, :lo12:var4
	str	w1, [x0]
	adrp	x0, var4
	add	x0, x0, :lo12:var4
	ldr	w0, [x0]
	cmp	w0, 0
	bne	.L4
	b	.L8

.L7:
	adrp	x0, var2
	add	x0, x0, :lo12:var2
	ldrb	w1, [x0]
	adrp	x0, var2
	add	x0, x0, :lo12:var2
	strb	w1, [x0]
	b	.L6

.L8:
	adrp	x0, var3
	add	x0, x0, :lo12:var3
	ldr	w0, [x0]
	cmp	w0, 3
	beq	.L7
	nop

3
.L6:
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
