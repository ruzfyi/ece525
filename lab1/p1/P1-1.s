	.arch armv8-a
	.file	"P1-1.c"
	.text
	.global	var1
	.data
	.type	var1, %object
	.size	var1, 1
var1:
	.byte	1
	.global	var2
	.type	var2, %object
	.size	var2, 1
var2:
	.byte	2
	.global	var3
	.align	2
	.type	var3, %object
	.size	var3, 4
var3:
	.word	3
	.global	var4
	.align	2
	.type	var4, %object
	.size	var4, 4
var4:
	.word	4
	.global	num
	.section	.rodata
	.align	2
	.type	num, %object
	.size	num, 4
num:
	.word	-10
	.global	wave
	.data
	.align	3
	.type	wave, %object
	.size	wave, 10
wave:
	.string	"goodbye!!"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w0, 5
	str	w0, [sp, 12]
	b	.L2
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
.L2:
	ldr	w0, [sp, 12]
	cmp	w0, 0
	bgt	.L3
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
