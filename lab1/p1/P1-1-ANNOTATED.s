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
	adrp	x0, var1	// calculate the base address of the memory page where var1 is
	add	x0, x0, :lo12:var1	// isolate the lower 12 bits
	ldrsb	w0, [x0]	// load var 1 as a signed var
	and	w1, w0, 255		// bitwise and promoting var1 to a byte sized int
	adrp	x0, var1	// recalculate the page base address
	add	x0, x0, :lo12:var1	// isolate the lower 12 bits again
	ldrsb	w0, [x0]	// load a signed bye into w0
	and	w0, w0, 255		// convert the value to an int again
	mul	w0, w1, w0		// multiply the two registers to do var1 * var1
	and	w0, w0, 255		// simulate byte overflow
	sxtb	w1, w0		// store the value in a 32 bit number
	adrp	x0, var1	// recompute the page size
	add	x0, x0, :lo12:var1
	strb	w1, [x0]	// store the lower 8 bits of var1
	adrp	x0, var1	// recompute page size
	add	x0, x0, :lo12:var1
	mov	w1, 1			// copy 1 into w1 because n/n is always 1
	strb	w1, [x0]	// store lower 8 bites of w1 into var1
	// end of var1/=var1
	adrp	x0, var1	// recompute page size
	add	x0, x0, :lo12:var1
	ldrsb	w0, [x0]	// load current value of var1 into w1
	and	w0, w0, 255		// mask w0 to an 8 bit number
	ubfiz	w0, w0, 1, 7	// 1 bit left shift as a shortcut of 2x
	and	w0, w0, 255		// mask result to 8 bits
	sxtb	w1, w0		// sign extend 32 bits into var1
	adrp	x0, var1	// recompute page size for var1
	add	x0, x0, :lo12:var1
	strb	w1, [x0]	// store the result of the addition
	adrp	x0, var1	// recompute page size
	add	x0, x0, :lo12:var1
	strb	wzr, [x0]	// store zero register into var1, a shortcut to n-n which is always 0
	ldr	w0, [sp, 12]	// load the loop counter value
	sub	w0, w0, #1		// subtract 1 from var5
	str	w0, [sp, 12]	// store var5 again

// for loop condition
.L2:
	ldr	w0, [sp, 12]	// get the current value of var5 from the stack
	cmp	w0, 0			// is var5 greater than 0? 
	bgt	.L3		// if the greater than flag is high then jump to L3 for the loop execution

// do while loop
.L4:
	adrp	x0, var4	// compute the page size of var4
	add	x0, x0, :lo12:var4
	ldr	w0, [x0]		// load 32 bit value of var4 because it's an int
	sub	w1, w0, #1		// subtract 1 from var4 store in a different register
	adrp	x0, var4	// recompute page size
	add	x0, x0, :lo12:var4
	str	w1, [x0]		// store the result back into var4
	adrp	x0, var4	// recompute page size
	add	x0, x0, :lo12:var4
	ldr	w0, [x0]		// reload the updated value
	cmp	w0, 0			// compare var4 and 0 for the var4>0 condition
	bne	.L4				// while it's not equal to var4 jump to the start of the do while loop
	b	.L8				// otherwise jump to the condition of the while loop

// body of while loop
.L7:
	adrp	x0, var2	// compute page size for var2
	add	x0, x0, :lo12:var2
	ldrb	w1, [x0]	// load var2 as a register byte
	adrp	x0, var2	// compute page size
	add	x0, x0, :lo12:var2
	strb	w1, [x0]	// store var2
	b	.L6				// jump down to the end because this will only run once in the program lifetime

// condition of while loop
.L8:
	adrp	x0, var3	// compute page size for var3
	add	x0, x0, :lo12:var3
	ldr	w0, [x0]		// load 32 bit value of var3 because it's an int
	cmp	w0, 3			// compare var3 to 3
	beq	.L7				// if they're equal jump to the body
	nop					// optimizatino for lightning on 4 bytes

// end of the program
.L6:
	nop					// 4 byte spacer which is a gcc optimization
	add	sp, sp, 16		// restore the stack pointer deallocating the 16 byte stack frame
	.cfi_def_cfa_offset 0	// declare to debuggers that the sp was reset to 0
	ret					// jumps back to the c runtime caller
	.cfi_endproc		// closes the cfi record

// terminal end of main
.LFE0:
	.size	main, .-main	// calucaltes the size of main
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"	// compiler version identification
	.section	.note.GNU-stack,"",@progbits	// notifies the linker that this does not require an executable stack
