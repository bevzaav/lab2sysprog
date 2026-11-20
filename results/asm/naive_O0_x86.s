	.file	"matmul.c"
	.text
	.local	A
	.comm	A,8388608,32
	.local	B
	.comm	B,8388608,32
	.local	C
	.comm	C,8388608,32
	.type	init_matrices, @function
init_matrices:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	$0, -8(%rbp)
	jmp	.L3
.L4:
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	addl	%eax, %edx
	movslq	%edx, %rax
	imulq	$-1840700269, %rax, %rax
	shrq	$32, %rax
	addl	%edx, %eax
	sarl	$2, %eax
	movl	%edx, %ecx
	sarl	$31, %ecx
	subl	%ecx, %eax
	movl	%eax, %ecx
	sall	$3, %ecx
	subl	%eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	addl	$1, %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	A(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	movl	-4(%rbp), %eax
	imull	-8(%rbp), %eax
	movl	%eax, %ecx
	movslq	%ecx, %rax
	imulq	$1717986919, %rax, %rax
	shrq	$32, %rax
	movl	%eax, %edx
	sarl	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	subl	%eax, %ecx
	movl	%ecx, %edx
	leal	1(%rdx), %eax
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%eax, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	B(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, (%rdx,%rax)
	addl	$1, -8(%rbp)
.L3:
	cmpl	$1023, -8(%rbp)
	jle	.L4
	addl	$1, -4(%rbp)
.L2:
	cmpl	$1023, -4(%rbp)
	jle	.L5
	nop
	nop
	popq	%rbp
	ret
	.size	init_matrices, .-init_matrices
	.type	matmul, @function
matmul:
	pushq	%rbp
	movq	%rsp, %rbp
	movl	$0, -4(%rbp)
	jmp	.L7
.L12:
	movl	$0, -8(%rbp)
	jmp	.L8
.L11:
	movl	$0, -12(%rbp)
	jmp	.L9
.L10:
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	(%rdx,%rax), %xmm1
	movl	-12(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	A(%rip), %rax
	movsd	(%rdx,%rax), %xmm2
	movl	-8(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	B(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movl	-8(%rbp), %eax
	cltq
	movl	-4(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	%xmm0, (%rdx,%rax)
	addl	$1, -12(%rbp)
.L9:
	cmpl	$1023, -12(%rbp)
	jle	.L10
	addl	$1, -8(%rbp)
.L8:
	cmpl	$1023, -8(%rbp)
	jle	.L11
	addl	$1, -4(%rbp)
.L7:
	cmpl	$1023, -4(%rbp)
	jle	.L12
	nop
	nop
	popq	%rbp
	ret
	.size	matmul, .-matmul
	.type	checksum, @function
checksum:
	pushq	%rbp
	movq	%rsp, %rbp
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L14
.L17:
	movl	$0, -16(%rbp)
	jmp	.L15
.L16:
	movl	-16(%rbp), %eax
	cltq
	movl	-12(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	addq	%rdx, %rax
	leaq	0(,%rax,8), %rdx
	leaq	C(%rip), %rax
	movsd	(%rdx,%rax), %xmm0
	movsd	-8(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rbp)
	addl	$1, -16(%rbp)
.L15:
	cmpl	$1023, -16(%rbp)
	jle	.L16
	addl	$1, -12(%rbp)
.L14:
	cmpl	$1023, -12(%rbp)
	jle	.L17
	movsd	-8(%rbp), %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	popq	%rbp
	ret
	.size	checksum, .-checksum
	.section	.rodata
.LC1:
	.string	"checksum=%.0f\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	cmpl	$1, -20(%rbp)
	jle	.L20
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	jmp	.L21
.L20:
	movl	$1, %eax
.L21:
	movl	%eax, -8(%rbp)
	call	init_matrices
	movl	$0, -4(%rbp)
	jmp	.L22
.L23:
	call	matmul
	addl	$1, -4(%rbp)
.L22:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jl	.L23
	call	checksum
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Debian 12.2.0-14+deb12u1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
