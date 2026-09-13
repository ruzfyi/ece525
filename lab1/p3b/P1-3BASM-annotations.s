	.section 	".text"
	.global 	next_char	
next_char:
	ADD 	r0,#1			// standard parameter register is always r0
							// also the standard return register
	MOV	pc,lr				// function return by restoring control flow
	.end
