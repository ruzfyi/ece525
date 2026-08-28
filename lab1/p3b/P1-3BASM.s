	.section 	".text"
	.global 	next_char
next_char:
	ADD 	r0,#1
	MOV	pc,lr
	.end
