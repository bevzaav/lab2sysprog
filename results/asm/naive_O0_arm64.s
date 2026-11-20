	.arch armv8-a
	.file	"matmul.c"
	.text
	.local	A
	.comm	A,8388608,8
	.local	B
	.comm	B,8388608,8
	.local	C
	.comm	C,8388608,8
	.align	2
	.type	init_matrices, %function
init_matrices:
.LFB6:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	wzr, [sp, 12]
	b	.L2
.L5:
	str	wzr, [sp, 8]
	b	.L3
.L4:
	ldr	w1, [sp, 12]
	ldr	w0, [sp, 8]
	add	w0, w1, w0
	mov	w1, 9363
	movk	w1, 0x9249, lsl 16
	smull	x1, w0, w1
	lsr	x1, x1, 32
	add	w1, w0, w1
	asr	w2, w1, 2
	asr	w1, w0, 31
	sub	w2, w2, w1
	mov	w1, w2
	lsl	w1, w1, 3
	sub	w1, w1, w2
	sub	w2, w0, w1
	add	w0, w2, 1
	scvtf	d0, w0
	adrp	x0, A
	add	x0, x0, :lo12:A
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	str	d0, [x0, x1, lsl 3]
	ldr	w1, [sp, 12]
	ldr	w0, [sp, 8]
	mul	w2, w1, w0
	mov	w0, 26215
	movk	w0, 0x6666, lsl 16
	smull	x0, w2, w0
	lsr	x0, x0, 32
	asr	w1, w0, 1
	asr	w0, w2, 31
	sub	w1, w1, w0
	mov	w0, w1
	lsl	w0, w0, 2
	add	w0, w0, w1
	sub	w1, w2, w0
	add	w0, w1, 1
	scvtf	d0, w0
	adrp	x0, B
	add	x0, x0, :lo12:B
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	str	d0, [x0, x1, lsl 3]
	adrp	x0, C
	add	x0, x0, :lo12:C
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	str	xzr, [x0, x1, lsl 3]
	ldr	w0, [sp, 8]
	add	w0, w0, 1
	str	w0, [sp, 8]
.L3:
	ldr	w0, [sp, 8]
	cmp	w0, 1023
	ble	.L4
	ldr	w0, [sp, 12]
	add	w0, w0, 1
	str	w0, [sp, 12]
.L2:
	ldr	w0, [sp, 12]
	cmp	w0, 1023
	ble	.L5
	nop
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE6:
	.size	init_matrices, .-init_matrices
	.align	2
	.type	matmul, %function
matmul:
.LFB7:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	wzr, [sp, 12]
	b	.L7
.L12:
	str	wzr, [sp, 8]
	b	.L8
.L11:
	str	wzr, [sp, 4]
	b	.L9
.L10:
	adrp	x0, C
	add	x0, x0, :lo12:C
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	ldr	d1, [x0, x1, lsl 3]
	adrp	x0, A
	add	x0, x0, :lo12:A
	ldrsw	x1, [sp, 4]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	ldr	d2, [x0, x1, lsl 3]
	adrp	x0, B
	add	x0, x0, :lo12:B
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 4]
	lsl	x2, x2, 10
	add	x1, x2, x1
	ldr	d0, [x0, x1, lsl 3]
	fmul	d0, d2, d0
	fadd	d0, d1, d0
	adrp	x0, C
	add	x0, x0, :lo12:C
	ldrsw	x1, [sp, 8]
	ldrsw	x2, [sp, 12]
	lsl	x2, x2, 10
	add	x1, x2, x1
	str	d0, [x0, x1, lsl 3]
	ldr	w0, [sp, 4]
	add	w0, w0, 1
	str	w0, [sp, 4]
.L9:
	ldr	w0, [sp, 4]
	cmp	w0, 1023
	ble	.L10
	ldr	w0, [sp, 8]
	add	w0, w0, 1
	str	w0, [sp, 8]
.L8:
	ldr	w0, [sp, 8]
	cmp	w0, 1023
	ble	.L11
	ldr	w0, [sp, 12]
	add	w0, w0, 1
	str	w0, [sp, 12]
.L7:
	ldr	w0, [sp, 12]
	cmp	w0, 1023
	ble	.L12
	nop
	nop
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE7:
	.size	matmul, .-matmul
	.align	2
	.type	checksum, %function
checksum:
.LFB8:
	.cfi_startproc
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	xzr, [sp, 8]
	str	wzr, [sp, 4]
	b	.L14
.L17:
	str	wzr, [sp]
	b	.L15
.L16:
	adrp	x0, C
	add	x0, x0, :lo12:C
	ldrsw	x1, [sp]
	ldrsw	x2, [sp, 4]
	lsl	x2, x2, 10
	add	x1, x2, x1
	ldr	d0, [x0, x1, lsl 3]
	ldr	d1, [sp, 8]
	fadd	d0, d1, d0
	str	d0, [sp, 8]
	ldr	w0, [sp]
	add	w0, w0, 1
	str	w0, [sp]
.L15:
	ldr	w0, [sp]
	cmp	w0, 1023
	ble	.L16
	ldr	w0, [sp, 4]
	add	w0, w0, 1
	str	w0, [sp, 4]
.L14:
	ldr	w0, [sp, 4]
	cmp	w0, 1023
	ble	.L17
	ldr	d0, [sp, 8]
	add	sp, sp, 16
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE8:
	.size	checksum, .-checksum
	.section	.rodata
	.align	3
.LC0:
	.string	"checksum=%.0f\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB9:
	.cfi_startproc
	stp	x29, x30, [sp, -48]!
	.cfi_def_cfa_offset 48
	.cfi_offset 29, -48
	.cfi_offset 30, -40
	mov	x29, sp
	str	w0, [sp, 28]
	str	x1, [sp, 16]
	ldr	w0, [sp, 28]
	cmp	w0, 1
	ble	.L20
	ldr	x0, [sp, 16]
	add	x0, x0, 8
	ldr	x0, [x0]
	bl	atoi
	b	.L21
.L20:
	mov	w0, 1
.L21:
	str	w0, [sp, 40]
	bl	init_matrices
	str	wzr, [sp, 44]
	b	.L22
.L23:
	bl	matmul
	ldr	w0, [sp, 44]
	add	w0, w0, 1
	str	w0, [sp, 44]
.L22:
	ldr	w1, [sp, 44]
	ldr	w0, [sp, 40]
	cmp	w1, w0
	blt	.L23
	bl	checksum
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 48
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE9:
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14+deb12u1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
