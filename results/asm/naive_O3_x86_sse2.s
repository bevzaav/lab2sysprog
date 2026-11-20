	.file	"matmul.c"
	.text
	.p2align 4
	.type	init_matrices, @function
init_matrices:
	movdqa	.LC2(%rip), %xmm5
	pxor	%xmm7, %xmm7
	leaq	A(%rip), %rsi
	movdqa	.LC0(%rip), %xmm4
	movdqa	%xmm7, %xmm8
	leaq	8192(%rsi), %rdx
	xorl	%ecx, %ecx
	movdqa	.LC1(%rip), %xmm2
	pcmpgtd	%xmm5, %xmm8
	movdqa	.LC3(%rip), %xmm3
	.p2align 4,,10
	.p2align 3
.L3:
	movd	%ecx, %xmm6
	movq	%rsi, %rax
	pshufd	$0, %xmm6, %xmm9
	movdqa	%xmm4, %xmm6
	.p2align 4,,10
	.p2align 3
.L2:
	movdqa	%xmm6, %xmm0
	movdqa	%xmm7, %xmm10
	movdqa	%xmm8, %xmm11
	addq	$32, %rax
	paddd	%xmm9, %xmm0
	movdqa	%xmm8, %xmm12
	paddd	%xmm2, %xmm6
	pcmpgtd	%xmm0, %xmm10
	pmuludq	%xmm0, %xmm11
	movdqa	%xmm0, %xmm1
	pmuludq	%xmm5, %xmm1
	pmuludq	%xmm5, %xmm10
	paddq	%xmm11, %xmm10
	movdqa	%xmm7, %xmm11
	psllq	$32, %xmm10
	paddq	%xmm10, %xmm1
	movdqa	%xmm0, %xmm10
	psrlq	$32, %xmm10
	pshufd	$221, %xmm1, %xmm1
	pcmpgtd	%xmm10, %xmm11
	pmuludq	%xmm10, %xmm12
	pmuludq	%xmm5, %xmm10
	pmuludq	%xmm5, %xmm11
	paddq	%xmm12, %xmm11
	psllq	$32, %xmm11
	paddq	%xmm11, %xmm10
	pshufd	$221, %xmm10, %xmm10
	punpckldq	%xmm10, %xmm1
	paddd	%xmm0, %xmm1
	psrad	$2, %xmm1
	movdqa	%xmm1, %xmm10
	pslld	$3, %xmm10
	psubd	%xmm1, %xmm10
	psubd	%xmm10, %xmm0
	paddd	%xmm3, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	pshufd	$238, %xmm0, %xmm0
	movaps	%xmm1, -32(%rax)
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L2
	addl	$1, %ecx
	addq	$8192, %rsi
	leaq	8192(%rax), %rdx
	cmpl	$1024, %ecx
	jne	.L3
	movdqa	.LC4(%rip), %xmm5
	pxor	%xmm7, %xmm7
	leaq	B(%rip), %rsi
	xorl	%ecx, %ecx
	movdqa	%xmm7, %xmm8
	leaq	8192(%rsi), %rdx
	pcmpgtd	%xmm5, %xmm8
	.p2align 4,,10
	.p2align 3
.L7:
	movd	%ecx, %xmm6
	movq	%rsi, %rax
	pshufd	$0, %xmm6, %xmm9
	movdqa	%xmm4, %xmm6
	movdqa	%xmm9, %xmm10
	psrlq	$32, %xmm10
	.p2align 4,,10
	.p2align 3
.L6:
	movdqa	%xmm6, %xmm1
	movdqa	%xmm7, %xmm12
	paddd	%xmm2, %xmm6
	addq	$32, %rax
	movdqa	%xmm1, %xmm0
	psrlq	$32, %xmm1
	movdqa	%xmm8, %xmm13
	pmuludq	%xmm9, %xmm0
	pmuludq	%xmm10, %xmm1
	pshufd	$8, %xmm0, %xmm0
	pshufd	$8, %xmm1, %xmm1
	punpckldq	%xmm1, %xmm0
	movdqa	%xmm8, %xmm1
	pcmpgtd	%xmm0, %xmm12
	pmuludq	%xmm0, %xmm1
	movdqa	%xmm0, %xmm11
	pmuludq	%xmm5, %xmm11
	pmuludq	%xmm5, %xmm12
	paddq	%xmm1, %xmm12
	movdqa	%xmm0, %xmm1
	psllq	$32, %xmm12
	psrlq	$32, %xmm1
	paddq	%xmm12, %xmm11
	pmuludq	%xmm1, %xmm13
	movdqa	%xmm7, %xmm12
	pcmpgtd	%xmm1, %xmm12
	pmuludq	%xmm5, %xmm1
	pshufd	$221, %xmm11, %xmm11
	pmuludq	%xmm5, %xmm12
	paddq	%xmm13, %xmm12
	psllq	$32, %xmm12
	paddq	%xmm12, %xmm1
	pshufd	$221, %xmm1, %xmm1
	punpckldq	%xmm1, %xmm11
	movdqa	%xmm11, %xmm1
	psrad	$1, %xmm1
	movdqa	%xmm1, %xmm11
	pslld	$2, %xmm11
	paddd	%xmm11, %xmm1
	psubd	%xmm1, %xmm0
	paddd	%xmm3, %xmm0
	cvtdq2pd	%xmm0, %xmm1
	pshufd	$238, %xmm0, %xmm0
	movaps	%xmm1, -32(%rax)
	cvtdq2pd	%xmm0, %xmm0
	movaps	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L6
	addl	$1, %ecx
	addq	$8192, %rsi
	leaq	8192(%rax), %rdx
	cmpl	$1024, %ecx
	jne	.L7
	movl	$8388608, %edx
	xorl	%esi, %esi
	leaq	C(%rip), %rdi
	jmp	memset@PLT
	.size	init_matrices, .-init_matrices
	.p2align 4
	.type	matmul, @function
matmul:
	leaq	8192+B(%rip), %r9
	pushq	%rbp
	leaq	C(%rip), %r11
	xorl	%r10d, %r10d
	pushq	%rbx
	leaq	A(%rip), %rbp
	leaq	8380416(%r9), %rbx
.L20:
	movq	%r10, %r8
	movq	%rbx, %rcx
	leaq	B(%rip), %rsi
	movq	%r11, %rdi
	salq	$13, %r8
	addq	%rbp, %r8
.L24:
	movapd	(%rdi), %xmm1
	movq	%rsi, %rax
	movq	%r8, %rdx
	.p2align 4,,10
	.p2align 3
.L21:
	movsd	(%rdx), %xmm0
	addq	$8192, %rax
	addq	$8, %rdx
	unpcklpd	%xmm0, %xmm0
	mulpd	-8192(%rax), %xmm0
	addpd	%xmm0, %xmm1
	cmpq	%rcx, %rax
	jne	.L21
	addq	$16, %rsi
	movaps	%xmm1, (%rdi)
	leaq	16(%rax), %rcx
	addq	$16, %rdi
	cmpq	%r9, %rsi
	jne	.L24
	addq	$1, %r10
	addq	$8192, %r11
	cmpq	$1024, %r10
	jne	.L20
	popq	%rbx
	popq	%rbp
	ret
	.size	matmul, .-matmul
	.p2align 4
	.type	checksum, @function
checksum:
	leaq	C(%rip), %rcx
	pxor	%xmm0, %xmm0
	leaq	8192(%rcx), %rdx
	leaq	8388608(%rdx), %rsi
	.p2align 4,,10
	.p2align 3
.L28:
	movq	%rcx, %rax
	.p2align 4,,10
	.p2align 3
.L29:
	addsd	(%rax), %xmm0
	addq	$16, %rax
	addsd	-8(%rax), %xmm0
	cmpq	%rdx, %rax
	jne	.L29
	leaq	8192(%rax), %rdx
	addq	$8192, %rcx
	cmpq	%rsi, %rdx
	jne	.L28
	ret
	.size	checksum, .-checksum
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC6:
	.string	"checksum=%.0f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	pushq	%rbx
	subq	$8, %rsp
	cmpl	$1, %edi
	jg	.L33
	call	init_matrices
	call	matmul
.L34:
	call	checksum
	leaq	.LC6(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	addq	$8, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	ret
.L33:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rax, %rbx
	movl	%eax, %ebp
	call	init_matrices
	testl	%ebx, %ebx
	jle	.L34
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L35:
	call	matmul
	addl	$1, %ebx
	cmpl	%ebp, %ebx
	jl	.L35
	jmp	.L34
	.size	main, .-main
	.local	C
	.comm	C,8388608,32
	.local	B
	.comm	B,8388608,32
	.local	A
	.comm	A,8388608,32
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC1:
	.long	4
	.long	4
	.long	4
	.long	4
	.align 16
.LC2:
	.long	-1840700269
	.long	-1840700269
	.long	-1840700269
	.long	-1840700269
	.align 16
.LC3:
	.long	1
	.long	1
	.long	1
	.long	1
	.align 16
.LC4:
	.long	1717986919
	.long	1717986919
	.long	1717986919
	.long	1717986919
	.ident	"GCC: (Debian 12.2.0-14+deb12u1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
