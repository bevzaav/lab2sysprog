	.file	"matmul.c"
	.text
	.p2align 4
	.type	init_matrices, @function
init_matrices:
	movl	$8, %eax
	leaq	A(%rip), %rsi
	vmovdqa	.LC0(%rip), %ymm2
	xorl	%ecx, %ecx
	vmovd	%eax, %xmm7
	movl	$-1840700269, %eax
	leaq	8192(%rsi), %rdx
	vmovd	%eax, %xmm4
	movl	$1, %eax
	vpbroadcastd	%xmm7, %ymm7
	vmovd	%eax, %xmm6
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm6, %ymm6
	.p2align 4,,10
	.p2align 3
.L3:
	vmovd	%ecx, %xmm5
	movq	%rsi, %rax
	vmovdqa	%ymm2, %ymm3
	vpbroadcastd	%xmm5, %ymm5
	.p2align 4,,10
	.p2align 3
.L2:
	vmovdqa	%ymm3, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm3, %ymm3
	vpaddd	%ymm5, %ymm0, %ymm0
	vpmuldq	%ymm4, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm4, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpaddd	%ymm0, %ymm1, %ymm1
	vpsrad	$2, %ymm1, %ymm1
	vpslld	$3, %ymm1, %ymm8
	vpsubd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vmovapd	%ymm1, -64(%rax)
	vcvtdq2pd	%xmm0, %ymm0
	vmovapd	%ymm0, -32(%rax)
	cmpq	%rdx, %rax
	jne	.L2
	addl	$1, %ecx
	addq	$8192, %rsi
	leaq	8192(%rax), %rdx
	cmpl	$1024, %ecx
	jne	.L3
	movl	$8, %eax
	leaq	B(%rip), %rsi
	xorl	%ecx, %ecx
	vmovd	%eax, %xmm7
	movl	$1717986919, %eax
	leaq	8192(%rsi), %rdx
	vmovd	%eax, %xmm4
	movl	$1, %eax
	vpbroadcastd	%xmm7, %ymm7
	vmovd	%eax, %xmm6
	vpbroadcastd	%xmm4, %ymm4
	vpbroadcastd	%xmm6, %ymm6
	.p2align 4,,10
	.p2align 3
.L7:
	vmovd	%ecx, %xmm5
	movq	%rsi, %rax
	vmovdqa	%ymm2, %ymm3
	vpbroadcastd	%xmm5, %ymm5
	.p2align 4,,10
	.p2align 3
.L6:
	vmovdqa	%ymm3, %ymm0
	addq	$64, %rax
	vpaddd	%ymm7, %ymm3, %ymm3
	vpmulld	%ymm5, %ymm0, %ymm0
	vpmuldq	%ymm4, %ymm0, %ymm1
	vpsrlq	$32, %ymm0, %ymm8
	vpmuldq	%ymm4, %ymm8, %ymm8
	vpshufd	$245, %ymm1, %ymm1
	vpblendd	$170, %ymm8, %ymm1, %ymm1
	vpsrad	$1, %ymm1, %ymm1
	vpslld	$2, %ymm1, %ymm8
	vpaddd	%ymm1, %ymm8, %ymm1
	vpsubd	%ymm1, %ymm0, %ymm0
	vpaddd	%ymm6, %ymm0, %ymm0
	vcvtdq2pd	%xmm0, %ymm1
	vextracti128	$0x1, %ymm0, %xmm0
	vmovapd	%ymm1, -64(%rax)
	vcvtdq2pd	%xmm0, %ymm0
	vmovapd	%ymm0, -32(%rax)
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
	vzeroupper
	jmp	memset@PLT
	.size	init_matrices, .-init_matrices
	.p2align 4
	.type	matmul, @function
matmul:
	leaq	C(%rip), %r9
	leaq	8+A(%rip), %r10
	leaq	8388608(%r9), %r11
.L20:
	leaq	B(%rip), %rcx
	movq	%r10, %rdi
	movl	$1, %r8d
.L25:
	vbroadcastsd	-8(%rdi), %ymm3
	vbroadcastsd	(%rdi), %ymm2
	movq	%r9, %rdx
	xorl	%eax, %eax
	leaq	8192(%rcx), %rsi
	.p2align 4,,10
	.p2align 3
.L22:
	vmovapd	(%rcx,%rax), %ymm1
	vmovapd	32(%rax,%rcx), %ymm0
	addq	$64, %rdx
	vfmadd213pd	-64(%rdx), %ymm3, %ymm1
	vfmadd213pd	-32(%rdx), %ymm3, %ymm0
	vfmadd231pd	(%rsi,%rax), %ymm2, %ymm1
	vfmadd231pd	32(%rsi,%rax), %ymm2, %ymm0
	addq	$64, %rax
	vmovapd	%ymm1, -64(%rdx)
	vmovapd	%ymm0, -32(%rdx)
	cmpq	$8192, %rax
	jne	.L22
	addl	$2, %r8d
	addq	$16384, %rcx
	addq	$16, %rdi
	cmpl	$1025, %r8d
	jne	.L25
	addq	$8192, %r9
	addq	$8192, %r10
	cmpq	%r11, %r9
	jne	.L20
	vzeroupper
	ret
	.size	matmul, .-matmul
	.p2align 4
	.type	checksum, @function
checksum:
	leaq	C(%rip), %rcx
	vxorpd	%xmm0, %xmm0, %xmm0
	leaq	8192(%rcx), %rdx
	leaq	8388608(%rdx), %rsi
	.p2align 4,,10
	.p2align 3
.L30:
	movq	%rcx, %rax
	.p2align 4,,10
	.p2align 3
.L31:
	vaddsd	(%rax), %xmm0, %xmm0
	addq	$32, %rax
	vaddsd	-24(%rax), %xmm0, %xmm0
	vaddsd	-16(%rax), %xmm0, %xmm0
	vaddsd	-8(%rax), %xmm0, %xmm0
	cmpq	%rdx, %rax
	jne	.L31
	leaq	8192(%rax), %rdx
	addq	$8192, %rcx
	cmpq	%rsi, %rdx
	jne	.L30
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
	jg	.L35
	call	init_matrices
	call	matmul
.L36:
	call	checksum
	leaq	.LC6(%rip), %rdi
	movl	$1, %eax
	call	printf@PLT
	addq	$8, %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%rbp
	ret
.L35:
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rax, %rbx
	movl	%eax, %ebp
	call	init_matrices
	testl	%ebx, %ebx
	jle	.L36
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L37:
	call	matmul
	addl	$1, %ebx
	cmpl	%ebp, %ebx
	jl	.L37
	jmp	.L36
	.size	main, .-main
	.local	C
	.comm	C,8388608,32
	.local	B
	.comm	B,8388608,32
	.local	A
	.comm	A,8388608,32
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.long	0
	.long	1
	.long	2
	.long	3
	.long	4
	.long	5
	.long	6
	.long	7
	.ident	"GCC: (Debian 12.2.0-14+deb12u1) 12.2.0"
	.section	.note.GNU-stack,"",@progbits
