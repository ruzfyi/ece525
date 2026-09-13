	.arch armv8-a
	.file	"P1-3B.c"
	.text
	.section	.rodata		// store the string Next Character as a constant in rodata
	.align	3				// align along 8 byte memory boundary for string size
.LC0:
	.string	"Next Character= %c\n"	// store the string constant
	.text					// switch back to the program segment
	.align	2				// align instruction on 4 byte boundary
	.global	main			// define the main section
	.type	main, %function	// mark main as a function
main:
.LFB0:						// local function 0 definition
	.cfi_startproc
	stp	x29, x30, [sp, -16]!	// store pair for the function call and save the return point
	.cfi_def_cfa_offset 16	// update the debugger on the SP update
	.cfi_offset 29, -16		// records the location of the x26 value
	.cfi_offset 30, -8		// records the location of the x30 value
	mov	x29, sp				// point frame pointer to stack frame
	mov	w0, 65				// load A into the first argument register
	bl	next_char			// perform the function call to next_char taking w0 as the parameter
	and	w0, w0, 255			// isolates the lower 8 bits
	mov	w1, w0				// save the character result
	adrp	x0, .LC0		// measure the page address for the string message
	add	x0, x0, :lo12:.LC0	// add 12 bit offset and adding the message as the function parameter
	bl	printf				// call the standard print function	
	nop						// spacer
	ldp	x29, x30, [sp], 16	//restor ethe frame pointer and link register and deallocate the stack frame
	.cfi_restore 30			// update on x30
	.cfi_restore 29			// update on x29
	.cfi_def_cfa_offset 0	// notify of reset the stack offset
	ret						// return control to the caller
	.cfi_endproc			// closes the cfi record
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Debian 14.2.0-19) 14.2.0"
	.section	.note.GNU-stack,"",@progbits
