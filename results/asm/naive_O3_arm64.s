	.arch armv8-a
	.file	"matmul.c"
	.text
	.align	2
	.p2align 4,,11
	.type	init_matrices, %function
init_matrices:
.LFB22:
	.cfi_startproc
	adrp	x4, .LC0
	adrp	x0, A
	add	x0, x0, :lo12:A
	mov	w2, 0
	movi	v7.4s, 0x4
	add	x3, x0, 8192
	ldr	q4, [x4, #:lo12:.LC0]
	mov	x1, x3
	movi	v6.4s, 0x1
	.p2align 3,,7
.L3:
	adrp	x4, .LC1
	dup	v5.4s, w2
	ldr	q3, [x4, #:lo12:.LC1]
	.p2align 3,,7
.L2:
	mov	v0.16b, v3.16b
	add	v3.4s, v3.4s, v7.4s
	add	v0.4s, v0.4s, v5.4s
	smull2	v2.2d, v0.4s, v4.4s
	smull	v1.2d, v0.2s, v4.2s
	uzp2	v1.4s, v1.4s, v2.4s
	add	v1.4s, v1.4s, v0.4s
	sshr	v1.4s, v1.4s, 2
	shl	v2.4s, v1.4s, 3
	sub	v1.4s, v2.4s, v1.4s
	sub	v0.4s, v0.4s, v1.4s
	add	v0.4s, v0.4s, v6.4s
	sxtl	v1.2d, v0.2s
	sxtl2	v0.2d, v0.4s
	scvtf	v1.2d, v1.2d
	scvtf	v0.2d, v0.2d
	stp	q1, q0, [x0]
	add	x0, x0, 32
	cmp	x0, x1
	bne	.L2
	add	w2, w2, 1
	add	x1, x0, 8192
	mov	x0, x3
	cmp	w2, 1024
	beq	.L14
	add	x3, x3, 8192
	b	.L3
.L14:
	adrp	x4, .LC2
	adrp	x0, B
	add	x0, x0, :lo12:B
	mov	w2, 0
	movi	v7.4s, 0x4
	add	x3, x0, 8192
	ldr	q4, [x4, #:lo12:.LC2]
	mov	x1, x3
	movi	v6.4s, 0x1
	.p2align 3,,7
.L7:
	adrp	x4, .LC1
	dup	v5.4s, w2
	ldr	q3, [x4, #:lo12:.LC1]
	.p2align 3,,7
.L6:
	mov	v0.16b, v3.16b
	add	v3.4s, v3.4s, v7.4s
	mul	v0.4s, v0.4s, v5.4s
	smull2	v2.2d, v0.4s, v4.4s
	smull	v1.2d, v0.2s, v4.2s
	uzp2	v1.4s, v1.4s, v2.4s
	sshr	v1.4s, v1.4s, 1
	shl	v2.4s, v1.4s, 2
	add	v1.4s, v2.4s, v1.4s
	sub	v0.4s, v0.4s, v1.4s
	add	v0.4s, v0.4s, v6.4s
	sxtl	v1.2d, v0.2s
	sxtl2	v0.2d, v0.4s
	scvtf	v1.2d, v1.2d
	scvtf	v0.2d, v0.2d
	stp	q1, q0, [x0]
	add	x0, x0, 32
	cmp	x0, x1
	bne	.L6
	add	w2, w2, 1
	add	x1, x0, 8192
	mov	x0, x3
	cmp	w2, 1024
	beq	.L16
	add	x3, x3, 8192
	b	.L7
.L16:
	adrp	x0, C
	mov	x2, 8388608
	add	x0, x0, :lo12:C
	mov	w1, 0
	b	memset
	.cfi_endproc
.LFE22:
	.size	init_matrices, .-init_matrices
	.align	2
	.p2align 4,,11
	.type	matmul, %function
matmul:
.LFB23:
	.cfi_startproc
	adrp	x3, A
	add	x3, x3, :lo12:A
	adrp	x6, C
	adrp	x5, B+8192
	add	x8, x3, 8388608
	add	x6, x6, :lo12:C
	add	x5, x5, :lo12:B+8192
	adrp	x7, B
.L20:
	mov	x4, x6
	add	x2, x7, :lo12:B
.L24:
	ldr	q0, [x4]
	mov	x0, 0
	.p2align 3,,7
.L21:
	lsl	x1, x0, 13
	ldr	d2, [x3, x0, lsl 3]
	add	x0, x0, 1
	ldr	q1, [x2, x1]
	fmla	v0.2d, v1.2d, v2.d[0]
	cmp	x0, 1024
	bne	.L21
	add	x2, x2, 16
	str	q0, [x4], 16
	cmp	x2, x5
	bne	.L24
	add	x3, x3, 8192
	add	x6, x6, 8192
	cmp	x3, x8
	bne	.L20
	ret
	.cfi_endproc
.LFE23:
	.size	matmul, .-matmul
	.align	2
	.p2align 4,,11
	.type	checksum, %function
checksum:
.LFB24:
	.cfi_startproc
	adrp	x2, C
	movi	d0, #0
	add	x2, x2, :lo12:C
	add	x1, x2, 8192
	add	x2, x2, 8396800
	.p2align 3,,7
.L27:
	sub	x0, x1, #8192
	.p2align 3,,7
.L28:
	ldr	d1, [x0], 8
	fadd	d0, d0, d1
	cmp	x0, x1
	bne	.L28
	add	x1, x0, 8192
	cmp	x1, x2
	bne	.L27
	ret
	.cfi_endproc
.LFE24:
	.size	checksum, .-checksum
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC3:
	.string	"checksum=%.0f\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 4,,11
	.global	main
	.type	main, %function
main:
.LFB25:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	cmp	w0, 1
	bgt	.L32
	bl	init_matrices
	bl	matmul
.L33:
	bl	checksum
	adrp	x0, .LC3
	add	x0, x0, :lo12:.LC3
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
.L32:
	.cfi_restore_state
	ldr	x0, [x1, 8]
	mov	w2, 10
	mov	x1, 0
	stp	x19, x20, [sp, 16]
	.cfi_offset 20, -8
	.cfi_offset 19, -16
	bl	strtol
	mov	x20, x0
	mov	w19, w0
	bl	init_matrices
	cmp	w20, 0
	ble	.L37
	mov	w9, 0
	.p2align 3,,7
.L34:
	add	w9, w9, 1
	bl	matmul
	cmp	w9, w19
	blt	.L34
.L37:
	ldp	x19, x20, [sp, 16]
	.cfi_restore 20
	.cfi_restore 19
	b	.L33
	.cfi_endproc
.LFE25:
	.size	main, .-main
	.section	.rodata.cst16,"aM",@progbits,16
	.align	4
.LC0:
	.word	-1840700269
	.word	-1840700269
	.word	-1840700269
	.word	-1840700269
	.align	4
.LC1:
	.word	0
	.word	1
	.word	2
	.word	3
	.align	4
.LC2:
	.word	1717986919
	.word	1717986919
	.word	1717986919
	.word	1717986919
	.bss
	.align	4
	.type	C, %object
	.size	C, 8388608
C:
	.zero	8388608
	.type	B, %object
	.size	B, 8388608
B:
	.zero	8388608
	.type	A, %object
	.size	A, 8388608
A:
	.zero	8388608
	.ident	"GCC: (Debian 12.2.0-14+deb12u1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
