.text	



.globl	sha1_multi_block
.type	sha1_multi_block,@function
.align	32
sha1_multi_block:
	movq	OPENSSL_ia32cap_P+4(%rip),%rcx
	testl	$268435456,%ecx
	jnz	_avx_shortcut
	movq	%rsp,%rax
	pushq	%rbx
	pushq	%rbp
	subq	$288,%rsp
	andq	$-256,%rsp
	movq	%rax,272(%rsp)
	leaq	K_XX_XX(%rip),%rbp
	leaq	256(%rsp),%rbx

.Loop_grande:
	movl	%edx,280(%rsp)
	xorl	%edx,%edx
	movq	0(%rsi),%r8
	movl	8(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,0(%rbx)
	cmovleq	%rbp,%r8
	movq	16(%rsi),%r9
	movl	24(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,4(%rbx)
	cmovleq	%rbp,%r9
	movq	32(%rsi),%r10
	movl	40(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,8(%rbx)
	cmovleq	%rbp,%r10
	movq	48(%rsi),%r11
	movl	56(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,12(%rbx)
	cmovleq	%rbp,%r11
	testl	%edx,%edx
	jz	.Ldone

	movdqu	0(%rdi),%xmm10
	leaq	128(%rsp),%rax
	movdqu	32(%rdi),%xmm11
	movdqu	64(%rdi),%xmm12
	movdqu	96(%rdi),%xmm13
	movdqu	128(%rdi),%xmm14
	movdqa	96(%rbp),%xmm5
	movdqa	-32(%rbp),%xmm15
	jmp	.Loop

.align	32
.Loop:
	movd	(%r8),%xmm0
	leaq	64(%r8),%r8
	movd	(%r9),%xmm2
	leaq	64(%r9),%r9
	movd	(%r10),%xmm3
	leaq	64(%r10),%r10
	movd	(%r11),%xmm4
	leaq	64(%r11),%r11
	punpckldq	%xmm3,%xmm0
	movd	-60(%r8),%xmm1
	punpckldq	%xmm4,%xmm2
	movd	-60(%r9),%xmm9
	punpckldq	%xmm2,%xmm0
	movd	-60(%r10),%xmm8
.byte	102,15,56,0,197
	movd	-60(%r11),%xmm7
	punpckldq	%xmm8,%xmm1
	movdqa	%xmm10,%xmm8
	paddd	%xmm15,%xmm14
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm11,%xmm7
	movdqa	%xmm11,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm13,%xmm7
	pand	%xmm12,%xmm6
	punpckldq	%xmm9,%xmm1
	movdqa	%xmm10,%xmm9

	movdqa	%xmm0,0-128(%rax)
	paddd	%xmm0,%xmm14
	movd	-56(%r8),%xmm2
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm11,%xmm7

	por	%xmm9,%xmm8
	movd	-56(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
.byte	102,15,56,0,205
	movd	-60(%r10),%xmm8
	por	%xmm7,%xmm11
	movd	-56(%r11),%xmm7
	punpckldq	%xmm8,%xmm2
	movdqa	%xmm14,%xmm8
	paddd	%xmm15,%xmm13
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm10,%xmm7
	movdqa	%xmm10,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm12,%xmm7
	pand	%xmm11,%xmm6
	punpckldq	%xmm9,%xmm2
	movdqa	%xmm14,%xmm9

	movdqa	%xmm1,16-128(%rax)
	paddd	%xmm1,%xmm13
	movd	-52(%r8),%xmm3
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm10,%xmm7

	por	%xmm9,%xmm8
	movd	-52(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
.byte	102,15,56,0,213
	movd	-56(%r10),%xmm8
	por	%xmm7,%xmm10
	movd	-52(%r11),%xmm7
	punpckldq	%xmm8,%xmm3
	movdqa	%xmm13,%xmm8
	paddd	%xmm15,%xmm12
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm14,%xmm7
	movdqa	%xmm14,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm11,%xmm7
	pand	%xmm10,%xmm6
	punpckldq	%xmm9,%xmm3
	movdqa	%xmm13,%xmm9

	movdqa	%xmm2,32-128(%rax)
	paddd	%xmm2,%xmm12
	movd	-48(%r8),%xmm4
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm14,%xmm7

	por	%xmm9,%xmm8
	movd	-48(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
.byte	102,15,56,0,221
	movd	-52(%r10),%xmm8
	por	%xmm7,%xmm14
	movd	-48(%r11),%xmm7
	punpckldq	%xmm8,%xmm4
	movdqa	%xmm12,%xmm8
	paddd	%xmm15,%xmm11
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm13,%xmm7
	movdqa	%xmm13,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm10,%xmm7
	pand	%xmm14,%xmm6
	punpckldq	%xmm9,%xmm4
	movdqa	%xmm12,%xmm9

	movdqa	%xmm3,48-128(%rax)
	paddd	%xmm3,%xmm11
	movd	-44(%r8),%xmm0
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm13,%xmm7

	por	%xmm9,%xmm8
	movd	-44(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
.byte	102,15,56,0,229
	movd	-48(%r10),%xmm8
	por	%xmm7,%xmm13
	movd	-44(%r11),%xmm7
	punpckldq	%xmm8,%xmm0
	movdqa	%xmm11,%xmm8
	paddd	%xmm15,%xmm10
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm12,%xmm7
	movdqa	%xmm12,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm14,%xmm7
	pand	%xmm13,%xmm6
	punpckldq	%xmm9,%xmm0
	movdqa	%xmm11,%xmm9

	movdqa	%xmm4,64-128(%rax)
	paddd	%xmm4,%xmm10
	movd	-40(%r8),%xmm1
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm12,%xmm7

	por	%xmm9,%xmm8
	movd	-40(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
.byte	102,15,56,0,197
	movd	-44(%r10),%xmm8
	por	%xmm7,%xmm12
	movd	-40(%r11),%xmm7
	punpckldq	%xmm8,%xmm1
	movdqa	%xmm10,%xmm8
	paddd	%xmm15,%xmm14
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm11,%xmm7
	movdqa	%xmm11,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm13,%xmm7
	pand	%xmm12,%xmm6
	punpckldq	%xmm9,%xmm1
	movdqa	%xmm10,%xmm9

	movdqa	%xmm0,80-128(%rax)
	paddd	%xmm0,%xmm14
	movd	-36(%r8),%xmm2
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm11,%xmm7

	por	%xmm9,%xmm8
	movd	-36(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
.byte	102,15,56,0,205
	movd	-40(%r10),%xmm8
	por	%xmm7,%xmm11
	movd	-36(%r11),%xmm7
	punpckldq	%xmm8,%xmm2
	movdqa	%xmm14,%xmm8
	paddd	%xmm15,%xmm13
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm10,%xmm7
	movdqa	%xmm10,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm12,%xmm7
	pand	%xmm11,%xmm6
	punpckldq	%xmm9,%xmm2
	movdqa	%xmm14,%xmm9

	movdqa	%xmm1,96-128(%rax)
	paddd	%xmm1,%xmm13
	movd	-32(%r8),%xmm3
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm10,%xmm7

	por	%xmm9,%xmm8
	movd	-32(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
.byte	102,15,56,0,213
	movd	-36(%r10),%xmm8
	por	%xmm7,%xmm10
	movd	-32(%r11),%xmm7
	punpckldq	%xmm8,%xmm3
	movdqa	%xmm13,%xmm8
	paddd	%xmm15,%xmm12
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm14,%xmm7
	movdqa	%xmm14,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm11,%xmm7
	pand	%xmm10,%xmm6
	punpckldq	%xmm9,%xmm3
	movdqa	%xmm13,%xmm9

	movdqa	%xmm2,112-128(%rax)
	paddd	%xmm2,%xmm12
	movd	-28(%r8),%xmm4
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm14,%xmm7

	por	%xmm9,%xmm8
	movd	-28(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
.byte	102,15,56,0,221
	movd	-32(%r10),%xmm8
	por	%xmm7,%xmm14
	movd	-28(%r11),%xmm7
	punpckldq	%xmm8,%xmm4
	movdqa	%xmm12,%xmm8
	paddd	%xmm15,%xmm11
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm13,%xmm7
	movdqa	%xmm13,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm10,%xmm7
	pand	%xmm14,%xmm6
	punpckldq	%xmm9,%xmm4
	movdqa	%xmm12,%xmm9

	movdqa	%xmm3,128-128(%rax)
	paddd	%xmm3,%xmm11
	movd	-24(%r8),%xmm0
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm13,%xmm7

	por	%xmm9,%xmm8
	movd	-24(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
.byte	102,15,56,0,229
	movd	-28(%r10),%xmm8
	por	%xmm7,%xmm13
	movd	-24(%r11),%xmm7
	punpckldq	%xmm8,%xmm0
	movdqa	%xmm11,%xmm8
	paddd	%xmm15,%xmm10
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm12,%xmm7
	movdqa	%xmm12,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm14,%xmm7
	pand	%xmm13,%xmm6
	punpckldq	%xmm9,%xmm0
	movdqa	%xmm11,%xmm9

	movdqa	%xmm4,144-128(%rax)
	paddd	%xmm4,%xmm10
	movd	-20(%r8),%xmm1
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm12,%xmm7

	por	%xmm9,%xmm8
	movd	-20(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
.byte	102,15,56,0,197
	movd	-24(%r10),%xmm8
	por	%xmm7,%xmm12
	movd	-20(%r11),%xmm7
	punpckldq	%xmm8,%xmm1
	movdqa	%xmm10,%xmm8
	paddd	%xmm15,%xmm14
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm11,%xmm7
	movdqa	%xmm11,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm13,%xmm7
	pand	%xmm12,%xmm6
	punpckldq	%xmm9,%xmm1
	movdqa	%xmm10,%xmm9

	movdqa	%xmm0,160-128(%rax)
	paddd	%xmm0,%xmm14
	movd	-16(%r8),%xmm2
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm11,%xmm7

	por	%xmm9,%xmm8
	movd	-16(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
.byte	102,15,56,0,205
	movd	-20(%r10),%xmm8
	por	%xmm7,%xmm11
	movd	-16(%r11),%xmm7
	punpckldq	%xmm8,%xmm2
	movdqa	%xmm14,%xmm8
	paddd	%xmm15,%xmm13
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm10,%xmm7
	movdqa	%xmm10,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm12,%xmm7
	pand	%xmm11,%xmm6
	punpckldq	%xmm9,%xmm2
	movdqa	%xmm14,%xmm9

	movdqa	%xmm1,176-128(%rax)
	paddd	%xmm1,%xmm13
	movd	-12(%r8),%xmm3
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm10,%xmm7

	por	%xmm9,%xmm8
	movd	-12(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
.byte	102,15,56,0,213
	movd	-16(%r10),%xmm8
	por	%xmm7,%xmm10
	movd	-12(%r11),%xmm7
	punpckldq	%xmm8,%xmm3
	movdqa	%xmm13,%xmm8
	paddd	%xmm15,%xmm12
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm14,%xmm7
	movdqa	%xmm14,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm11,%xmm7
	pand	%xmm10,%xmm6
	punpckldq	%xmm9,%xmm3
	movdqa	%xmm13,%xmm9

	movdqa	%xmm2,192-128(%rax)
	paddd	%xmm2,%xmm12
	movd	-8(%r8),%xmm4
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm14,%xmm7

	por	%xmm9,%xmm8
	movd	-8(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
.byte	102,15,56,0,221
	movd	-12(%r10),%xmm8
	por	%xmm7,%xmm14
	movd	-8(%r11),%xmm7
	punpckldq	%xmm8,%xmm4
	movdqa	%xmm12,%xmm8
	paddd	%xmm15,%xmm11
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm13,%xmm7
	movdqa	%xmm13,%xmm6
	pslld	$5,%xmm8
	pandn	%xmm10,%xmm7
	pand	%xmm14,%xmm6
	punpckldq	%xmm9,%xmm4
	movdqa	%xmm12,%xmm9

	movdqa	%xmm3,208-128(%rax)
	paddd	%xmm3,%xmm11
	movd	-4(%r8),%xmm0
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm13,%xmm7

	por	%xmm9,%xmm8
	movd	-4(%r9),%xmm9
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
.byte	102,15,56,0,229
	movd	-8(%r10),%xmm8
	por	%xmm7,%xmm13
	movdqa	0-128(%rax),%xmm1
	movd	-4(%r11),%xmm7
	punpckldq	%xmm8,%xmm0
	movdqa	%xmm11,%xmm8
	paddd	%xmm15,%xmm10
	punpckldq	%xmm7,%xmm9
	movdqa	%xmm12,%xmm7
	movdqa	%xmm12,%xmm6
	pslld	$5,%xmm8
	prefetcht0	63(%r8)
	pandn	%xmm14,%xmm7
	pand	%xmm13,%xmm6
	punpckldq	%xmm9,%xmm0
	movdqa	%xmm11,%xmm9

	movdqa	%xmm4,224-128(%rax)
	paddd	%xmm4,%xmm10
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6
	movdqa	%xmm12,%xmm7
	prefetcht0	63(%r9)

	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm10
	prefetcht0	63(%r10)

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
.byte	102,15,56,0,197
	prefetcht0	63(%r11)
	por	%xmm7,%xmm12
	movdqa	16-128(%rax),%xmm2
	pxor	%xmm3,%xmm1
	movdqa	32-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	pxor	128-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	movdqa	%xmm11,%xmm7
	pslld	$5,%xmm8
	pxor	%xmm3,%xmm1
	movdqa	%xmm11,%xmm6
	pandn	%xmm13,%xmm7
	movdqa	%xmm1,%xmm5
	pand	%xmm12,%xmm6
	movdqa	%xmm10,%xmm9
	psrld	$31,%xmm5
	paddd	%xmm1,%xmm1

	movdqa	%xmm0,240-128(%rax)
	paddd	%xmm0,%xmm14
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6

	movdqa	%xmm11,%xmm7
	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	48-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	pxor	144-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	movdqa	%xmm10,%xmm7
	pslld	$5,%xmm8
	pxor	%xmm4,%xmm2
	movdqa	%xmm10,%xmm6
	pandn	%xmm12,%xmm7
	movdqa	%xmm2,%xmm5
	pand	%xmm11,%xmm6
	movdqa	%xmm14,%xmm9
	psrld	$31,%xmm5
	paddd	%xmm2,%xmm2

	movdqa	%xmm1,0-128(%rax)
	paddd	%xmm1,%xmm13
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6

	movdqa	%xmm10,%xmm7
	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	64-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	pxor	160-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	movdqa	%xmm14,%xmm7
	pslld	$5,%xmm8
	pxor	%xmm0,%xmm3
	movdqa	%xmm14,%xmm6
	pandn	%xmm11,%xmm7
	movdqa	%xmm3,%xmm5
	pand	%xmm10,%xmm6
	movdqa	%xmm13,%xmm9
	psrld	$31,%xmm5
	paddd	%xmm3,%xmm3

	movdqa	%xmm2,16-128(%rax)
	paddd	%xmm2,%xmm12
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6

	movdqa	%xmm14,%xmm7
	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	80-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	pxor	176-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	movdqa	%xmm13,%xmm7
	pslld	$5,%xmm8
	pxor	%xmm1,%xmm4
	movdqa	%xmm13,%xmm6
	pandn	%xmm10,%xmm7
	movdqa	%xmm4,%xmm5
	pand	%xmm14,%xmm6
	movdqa	%xmm12,%xmm9
	psrld	$31,%xmm5
	paddd	%xmm4,%xmm4

	movdqa	%xmm3,32-128(%rax)
	paddd	%xmm3,%xmm11
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6

	movdqa	%xmm13,%xmm7
	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	96-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	pxor	192-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	movdqa	%xmm12,%xmm7
	pslld	$5,%xmm8
	pxor	%xmm2,%xmm0
	movdqa	%xmm12,%xmm6
	pandn	%xmm14,%xmm7
	movdqa	%xmm0,%xmm5
	pand	%xmm13,%xmm6
	movdqa	%xmm11,%xmm9
	psrld	$31,%xmm5
	paddd	%xmm0,%xmm0

	movdqa	%xmm4,48-128(%rax)
	paddd	%xmm4,%xmm10
	psrld	$27,%xmm9
	pxor	%xmm7,%xmm6

	movdqa	%xmm12,%xmm7
	por	%xmm9,%xmm8
	pslld	$30,%xmm7
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	movdqa	0(%rbp),%xmm15
	pxor	%xmm3,%xmm1
	movdqa	112-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	208-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,64-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	128-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	224-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,80-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	144-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	240-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,96-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	160-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	0-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,112-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	176-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	16-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,128-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	192-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	32-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,144-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	208-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	48-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,160-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	224-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	64-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,176-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	240-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	80-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,192-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	0-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	96-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,208-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	16-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	112-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,224-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	32-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	128-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,240-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	48-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	144-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,0-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	64-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	160-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,16-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	80-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	176-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,32-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	96-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	192-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,48-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	112-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	208-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,64-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	128-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	224-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,80-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	144-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	240-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,96-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	160-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	0-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,112-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	movdqa	32(%rbp),%xmm15
	pxor	%xmm3,%xmm1
	movdqa	176-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm7
	pxor	16-128(%rax),%xmm1
	pxor	%xmm3,%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	movdqa	%xmm10,%xmm9
	pand	%xmm12,%xmm7

	movdqa	%xmm13,%xmm6
	movdqa	%xmm1,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm14
	pxor	%xmm12,%xmm6

	movdqa	%xmm0,128-128(%rax)
	paddd	%xmm0,%xmm14
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm11,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm1,%xmm1
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	192-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm7
	pxor	32-128(%rax),%xmm2
	pxor	%xmm4,%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	movdqa	%xmm14,%xmm9
	pand	%xmm11,%xmm7

	movdqa	%xmm12,%xmm6
	movdqa	%xmm2,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm13
	pxor	%xmm11,%xmm6

	movdqa	%xmm1,144-128(%rax)
	paddd	%xmm1,%xmm13
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm10,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm2,%xmm2
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	208-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm7
	pxor	48-128(%rax),%xmm3
	pxor	%xmm0,%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	movdqa	%xmm13,%xmm9
	pand	%xmm10,%xmm7

	movdqa	%xmm11,%xmm6
	movdqa	%xmm3,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm12
	pxor	%xmm10,%xmm6

	movdqa	%xmm2,160-128(%rax)
	paddd	%xmm2,%xmm12
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm14,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm3,%xmm3
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	224-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm7
	pxor	64-128(%rax),%xmm4
	pxor	%xmm1,%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	movdqa	%xmm12,%xmm9
	pand	%xmm14,%xmm7

	movdqa	%xmm10,%xmm6
	movdqa	%xmm4,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm11
	pxor	%xmm14,%xmm6

	movdqa	%xmm3,176-128(%rax)
	paddd	%xmm3,%xmm11
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm13,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm4,%xmm4
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	240-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm7
	pxor	80-128(%rax),%xmm0
	pxor	%xmm2,%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	movdqa	%xmm11,%xmm9
	pand	%xmm13,%xmm7

	movdqa	%xmm14,%xmm6
	movdqa	%xmm0,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm10
	pxor	%xmm13,%xmm6

	movdqa	%xmm4,192-128(%rax)
	paddd	%xmm4,%xmm10
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm12,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm0,%xmm0
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	0-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm7
	pxor	96-128(%rax),%xmm1
	pxor	%xmm3,%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	movdqa	%xmm10,%xmm9
	pand	%xmm12,%xmm7

	movdqa	%xmm13,%xmm6
	movdqa	%xmm1,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm14
	pxor	%xmm12,%xmm6

	movdqa	%xmm0,208-128(%rax)
	paddd	%xmm0,%xmm14
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm11,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm1,%xmm1
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	16-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm7
	pxor	112-128(%rax),%xmm2
	pxor	%xmm4,%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	movdqa	%xmm14,%xmm9
	pand	%xmm11,%xmm7

	movdqa	%xmm12,%xmm6
	movdqa	%xmm2,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm13
	pxor	%xmm11,%xmm6

	movdqa	%xmm1,224-128(%rax)
	paddd	%xmm1,%xmm13
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm10,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm2,%xmm2
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	32-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm7
	pxor	128-128(%rax),%xmm3
	pxor	%xmm0,%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	movdqa	%xmm13,%xmm9
	pand	%xmm10,%xmm7

	movdqa	%xmm11,%xmm6
	movdqa	%xmm3,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm12
	pxor	%xmm10,%xmm6

	movdqa	%xmm2,240-128(%rax)
	paddd	%xmm2,%xmm12
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm14,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm3,%xmm3
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	48-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm7
	pxor	144-128(%rax),%xmm4
	pxor	%xmm1,%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	movdqa	%xmm12,%xmm9
	pand	%xmm14,%xmm7

	movdqa	%xmm10,%xmm6
	movdqa	%xmm4,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm11
	pxor	%xmm14,%xmm6

	movdqa	%xmm3,0-128(%rax)
	paddd	%xmm3,%xmm11
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm13,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm4,%xmm4
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	64-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm7
	pxor	160-128(%rax),%xmm0
	pxor	%xmm2,%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	movdqa	%xmm11,%xmm9
	pand	%xmm13,%xmm7

	movdqa	%xmm14,%xmm6
	movdqa	%xmm0,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm10
	pxor	%xmm13,%xmm6

	movdqa	%xmm4,16-128(%rax)
	paddd	%xmm4,%xmm10
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm12,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm0,%xmm0
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	80-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm7
	pxor	176-128(%rax),%xmm1
	pxor	%xmm3,%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	movdqa	%xmm10,%xmm9
	pand	%xmm12,%xmm7

	movdqa	%xmm13,%xmm6
	movdqa	%xmm1,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm14
	pxor	%xmm12,%xmm6

	movdqa	%xmm0,32-128(%rax)
	paddd	%xmm0,%xmm14
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm11,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm1,%xmm1
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	96-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm7
	pxor	192-128(%rax),%xmm2
	pxor	%xmm4,%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	movdqa	%xmm14,%xmm9
	pand	%xmm11,%xmm7

	movdqa	%xmm12,%xmm6
	movdqa	%xmm2,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm13
	pxor	%xmm11,%xmm6

	movdqa	%xmm1,48-128(%rax)
	paddd	%xmm1,%xmm13
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm10,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm2,%xmm2
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	112-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm7
	pxor	208-128(%rax),%xmm3
	pxor	%xmm0,%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	movdqa	%xmm13,%xmm9
	pand	%xmm10,%xmm7

	movdqa	%xmm11,%xmm6
	movdqa	%xmm3,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm12
	pxor	%xmm10,%xmm6

	movdqa	%xmm2,64-128(%rax)
	paddd	%xmm2,%xmm12
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm14,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm3,%xmm3
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	128-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm7
	pxor	224-128(%rax),%xmm4
	pxor	%xmm1,%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	movdqa	%xmm12,%xmm9
	pand	%xmm14,%xmm7

	movdqa	%xmm10,%xmm6
	movdqa	%xmm4,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm11
	pxor	%xmm14,%xmm6

	movdqa	%xmm3,80-128(%rax)
	paddd	%xmm3,%xmm11
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm13,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm4,%xmm4
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	144-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm7
	pxor	240-128(%rax),%xmm0
	pxor	%xmm2,%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	movdqa	%xmm11,%xmm9
	pand	%xmm13,%xmm7

	movdqa	%xmm14,%xmm6
	movdqa	%xmm0,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm10
	pxor	%xmm13,%xmm6

	movdqa	%xmm4,96-128(%rax)
	paddd	%xmm4,%xmm10
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm12,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm0,%xmm0
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	160-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm7
	pxor	0-128(%rax),%xmm1
	pxor	%xmm3,%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	movdqa	%xmm10,%xmm9
	pand	%xmm12,%xmm7

	movdqa	%xmm13,%xmm6
	movdqa	%xmm1,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm14
	pxor	%xmm12,%xmm6

	movdqa	%xmm0,112-128(%rax)
	paddd	%xmm0,%xmm14
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm11,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm1,%xmm1
	paddd	%xmm6,%xmm14

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	176-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm7
	pxor	16-128(%rax),%xmm2
	pxor	%xmm4,%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	movdqa	%xmm14,%xmm9
	pand	%xmm11,%xmm7

	movdqa	%xmm12,%xmm6
	movdqa	%xmm2,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm13
	pxor	%xmm11,%xmm6

	movdqa	%xmm1,128-128(%rax)
	paddd	%xmm1,%xmm13
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm10,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm2,%xmm2
	paddd	%xmm6,%xmm13

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	192-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm7
	pxor	32-128(%rax),%xmm3
	pxor	%xmm0,%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	movdqa	%xmm13,%xmm9
	pand	%xmm10,%xmm7

	movdqa	%xmm11,%xmm6
	movdqa	%xmm3,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm12
	pxor	%xmm10,%xmm6

	movdqa	%xmm2,144-128(%rax)
	paddd	%xmm2,%xmm12
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm14,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm3,%xmm3
	paddd	%xmm6,%xmm12

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	208-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm7
	pxor	48-128(%rax),%xmm4
	pxor	%xmm1,%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	movdqa	%xmm12,%xmm9
	pand	%xmm14,%xmm7

	movdqa	%xmm10,%xmm6
	movdqa	%xmm4,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm11
	pxor	%xmm14,%xmm6

	movdqa	%xmm3,160-128(%rax)
	paddd	%xmm3,%xmm11
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm13,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm4,%xmm4
	paddd	%xmm6,%xmm11

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	224-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm7
	pxor	64-128(%rax),%xmm0
	pxor	%xmm2,%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	movdqa	%xmm11,%xmm9
	pand	%xmm13,%xmm7

	movdqa	%xmm14,%xmm6
	movdqa	%xmm0,%xmm5
	psrld	$27,%xmm9
	paddd	%xmm7,%xmm10
	pxor	%xmm13,%xmm6

	movdqa	%xmm4,176-128(%rax)
	paddd	%xmm4,%xmm10
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	pand	%xmm12,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	paddd	%xmm0,%xmm0
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	movdqa	64(%rbp),%xmm15
	pxor	%xmm3,%xmm1
	movdqa	240-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	80-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,192-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	0-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	96-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,208-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	16-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	112-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,224-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	32-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	128-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,240-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	48-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	144-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,0-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	64-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	160-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,16-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	80-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	176-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,32-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	96-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	192-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	movdqa	%xmm2,48-128(%rax)
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	112-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	208-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	movdqa	%xmm3,64-128(%rax)
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	128-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	224-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	movdqa	%xmm4,80-128(%rax)
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	144-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	240-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	movdqa	%xmm0,96-128(%rax)
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	160-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	0-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	movdqa	%xmm1,112-128(%rax)
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	176-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	16-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	192-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	32-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	pxor	%xmm2,%xmm0
	movdqa	208-128(%rax),%xmm2

	movdqa	%xmm11,%xmm8
	movdqa	%xmm14,%xmm6
	pxor	48-128(%rax),%xmm0
	paddd	%xmm15,%xmm10
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	paddd	%xmm4,%xmm10
	pxor	%xmm2,%xmm0
	psrld	$27,%xmm9
	pxor	%xmm13,%xmm6
	movdqa	%xmm12,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm0,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm10
	paddd	%xmm0,%xmm0

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm5,%xmm0
	por	%xmm7,%xmm12
	pxor	%xmm3,%xmm1
	movdqa	224-128(%rax),%xmm3

	movdqa	%xmm10,%xmm8
	movdqa	%xmm13,%xmm6
	pxor	64-128(%rax),%xmm1
	paddd	%xmm15,%xmm14
	pslld	$5,%xmm8
	pxor	%xmm11,%xmm6

	movdqa	%xmm10,%xmm9
	paddd	%xmm0,%xmm14
	pxor	%xmm3,%xmm1
	psrld	$27,%xmm9
	pxor	%xmm12,%xmm6
	movdqa	%xmm11,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm1,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm14
	paddd	%xmm1,%xmm1

	psrld	$2,%xmm11
	paddd	%xmm8,%xmm14
	por	%xmm5,%xmm1
	por	%xmm7,%xmm11
	pxor	%xmm4,%xmm2
	movdqa	240-128(%rax),%xmm4

	movdqa	%xmm14,%xmm8
	movdqa	%xmm12,%xmm6
	pxor	80-128(%rax),%xmm2
	paddd	%xmm15,%xmm13
	pslld	$5,%xmm8
	pxor	%xmm10,%xmm6

	movdqa	%xmm14,%xmm9
	paddd	%xmm1,%xmm13
	pxor	%xmm4,%xmm2
	psrld	$27,%xmm9
	pxor	%xmm11,%xmm6
	movdqa	%xmm10,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm2,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm13
	paddd	%xmm2,%xmm2

	psrld	$2,%xmm10
	paddd	%xmm8,%xmm13
	por	%xmm5,%xmm2
	por	%xmm7,%xmm10
	pxor	%xmm0,%xmm3
	movdqa	0-128(%rax),%xmm0

	movdqa	%xmm13,%xmm8
	movdqa	%xmm11,%xmm6
	pxor	96-128(%rax),%xmm3
	paddd	%xmm15,%xmm12
	pslld	$5,%xmm8
	pxor	%xmm14,%xmm6

	movdqa	%xmm13,%xmm9
	paddd	%xmm2,%xmm12
	pxor	%xmm0,%xmm3
	psrld	$27,%xmm9
	pxor	%xmm10,%xmm6
	movdqa	%xmm14,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm3,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm12
	paddd	%xmm3,%xmm3

	psrld	$2,%xmm14
	paddd	%xmm8,%xmm12
	por	%xmm5,%xmm3
	por	%xmm7,%xmm14
	pxor	%xmm1,%xmm4
	movdqa	16-128(%rax),%xmm1

	movdqa	%xmm12,%xmm8
	movdqa	%xmm10,%xmm6
	pxor	112-128(%rax),%xmm4
	paddd	%xmm15,%xmm11
	pslld	$5,%xmm8
	pxor	%xmm13,%xmm6

	movdqa	%xmm12,%xmm9
	paddd	%xmm3,%xmm11
	pxor	%xmm1,%xmm4
	psrld	$27,%xmm9
	pxor	%xmm14,%xmm6
	movdqa	%xmm13,%xmm7

	pslld	$30,%xmm7
	movdqa	%xmm4,%xmm5
	por	%xmm9,%xmm8
	psrld	$31,%xmm5
	paddd	%xmm6,%xmm11
	paddd	%xmm4,%xmm4

	psrld	$2,%xmm13
	paddd	%xmm8,%xmm11
	por	%xmm5,%xmm4
	por	%xmm7,%xmm13
	movdqa	%xmm11,%xmm8
	paddd	%xmm15,%xmm10
	movdqa	%xmm14,%xmm6
	pslld	$5,%xmm8
	pxor	%xmm12,%xmm6

	movdqa	%xmm11,%xmm9
	paddd	%xmm4,%xmm10
	psrld	$27,%xmm9
	movdqa	%xmm12,%xmm7
	pxor	%xmm13,%xmm6

	pslld	$30,%xmm7
	por	%xmm9,%xmm8
	paddd	%xmm6,%xmm10

	psrld	$2,%xmm12
	paddd	%xmm8,%xmm10
	por	%xmm7,%xmm12
	movdqa	(%rbx),%xmm0
	movl	$1,%ecx
	cmpl	0(%rbx),%ecx
	pxor	%xmm8,%xmm8
	cmovgeq	%rbp,%r8
	cmpl	4(%rbx),%ecx
	movdqa	%xmm0,%xmm1
	cmovgeq	%rbp,%r9
	cmpl	8(%rbx),%ecx
	pcmpgtd	%xmm8,%xmm1
	cmovgeq	%rbp,%r10
	cmpl	12(%rbx),%ecx
	paddd	%xmm1,%xmm0
	cmovgeq	%rbp,%r11

	movdqu	0(%rdi),%xmm6
	pand	%xmm1,%xmm10
	movdqu	32(%rdi),%xmm7
	pand	%xmm1,%xmm11
	paddd	%xmm6,%xmm10
	movdqu	64(%rdi),%xmm8
	pand	%xmm1,%xmm12
	paddd	%xmm7,%xmm11
	movdqu	96(%rdi),%xmm9
	pand	%xmm1,%xmm13
	paddd	%xmm8,%xmm12
	movdqu	128(%rdi),%xmm5
	pand	%xmm1,%xmm14
	movdqu	%xmm10,0(%rdi)
	paddd	%xmm9,%xmm13
	movdqu	%xmm11,32(%rdi)
	paddd	%xmm5,%xmm14
	movdqu	%xmm12,64(%rdi)
	movdqu	%xmm13,96(%rdi)
	movdqu	%xmm14,128(%rdi)

	movdqa	%xmm0,(%rbx)
	movdqa	96(%rbp),%xmm5
	movdqa	-32(%rbp),%xmm15
	decl	%edx
	jnz	.Loop

	movl	280(%rsp),%edx
	leaq	16(%rdi),%rdi
	leaq	64(%rsi),%rsi
	decl	%edx
	jnz	.Loop_grande

.Ldone:
	movq	272(%rsp),%rax
	movq	-16(%rax),%rbp
	movq	-8(%rax),%rbx
	leaq	(%rax),%rsp
	.byte	0xf3,0xc3
.size	sha1_multi_block,.-sha1_multi_block
.type	sha1_multi_block_avx,@function
.align	32
sha1_multi_block_avx:
_avx_shortcut:
	movq	%rsp,%rax
	pushq	%rbx
	pushq	%rbp
	subq	$288,%rsp
	andq	$-256,%rsp
	movq	%rax,272(%rsp)
	leaq	K_XX_XX(%rip),%rbp
	leaq	256(%rsp),%rbx

	vzeroupper
.Loop_grande_avx:
	movl	%edx,280(%rsp)
	xorl	%edx,%edx
	movq	0(%rsi),%r8
	movl	8(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,0(%rbx)
	cmovleq	%rbp,%r8
	movq	16(%rsi),%r9
	movl	24(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,4(%rbx)
	cmovleq	%rbp,%r9
	movq	32(%rsi),%r10
	movl	40(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,8(%rbx)
	cmovleq	%rbp,%r10
	movq	48(%rsi),%r11
	movl	56(%rsi),%ecx
	cmpl	%edx,%ecx
	cmovgl	%ecx,%edx
	testl	%ecx,%ecx
	movl	%ecx,12(%rbx)
	cmovleq	%rbp,%r11
	testl	%edx,%edx
	jz	.Ldone_avx

	vmovdqu	0(%rdi),%xmm10
	leaq	128(%rsp),%rax
	vmovdqu	32(%rdi),%xmm11
	vmovdqu	64(%rdi),%xmm12
	vmovdqu	96(%rdi),%xmm13
	vmovdqu	128(%rdi),%xmm14
	vmovdqu	96(%rbp),%xmm5
	jmp	.Loop_avx

.align	32
.Loop_avx:
	vmovdqa	-32(%rbp),%xmm15
	vmovd	(%r8),%xmm0
	leaq	64(%r8),%r8
	vmovd	(%r9),%xmm2
	leaq	64(%r9),%r9
	vpinsrd	$1,(%r10),%xmm0,%xmm0
	leaq	64(%r10),%r10
	vpinsrd	$1,(%r11),%xmm2,%xmm2
	leaq	64(%r11),%r11
	vmovd	-60(%r8),%xmm1
	vpunpckldq	%xmm2,%xmm0,%xmm0
	vmovd	-60(%r9),%xmm9
	vpshufb	%xmm5,%xmm0,%xmm0
	vpinsrd	$1,-60(%r10),%xmm1,%xmm1
	vpinsrd	$1,-60(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpandn	%xmm13,%xmm11,%xmm7
	vpand	%xmm12,%xmm11,%xmm6

	vmovdqa	%xmm0,0-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpunpckldq	%xmm9,%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-56(%r8),%xmm2

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-56(%r9),%xmm9
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpshufb	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpinsrd	$1,-56(%r10),%xmm2,%xmm2
	vpinsrd	$1,-56(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpandn	%xmm12,%xmm10,%xmm7
	vpand	%xmm11,%xmm10,%xmm6

	vmovdqa	%xmm1,16-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpunpckldq	%xmm9,%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-52(%r8),%xmm3

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-52(%r9),%xmm9
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpshufb	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpinsrd	$1,-52(%r10),%xmm3,%xmm3
	vpinsrd	$1,-52(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpandn	%xmm11,%xmm14,%xmm7
	vpand	%xmm10,%xmm14,%xmm6

	vmovdqa	%xmm2,32-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpunpckldq	%xmm9,%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-48(%r8),%xmm4

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-48(%r9),%xmm9
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpshufb	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpinsrd	$1,-48(%r10),%xmm4,%xmm4
	vpinsrd	$1,-48(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpandn	%xmm10,%xmm13,%xmm7
	vpand	%xmm14,%xmm13,%xmm6

	vmovdqa	%xmm3,48-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpunpckldq	%xmm9,%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-44(%r8),%xmm0

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-44(%r9),%xmm9
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpshufb	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpinsrd	$1,-44(%r10),%xmm0,%xmm0
	vpinsrd	$1,-44(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpandn	%xmm14,%xmm12,%xmm7
	vpand	%xmm13,%xmm12,%xmm6

	vmovdqa	%xmm4,64-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpunpckldq	%xmm9,%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-40(%r8),%xmm1

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-40(%r9),%xmm9
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpshufb	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpinsrd	$1,-40(%r10),%xmm1,%xmm1
	vpinsrd	$1,-40(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpandn	%xmm13,%xmm11,%xmm7
	vpand	%xmm12,%xmm11,%xmm6

	vmovdqa	%xmm0,80-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpunpckldq	%xmm9,%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-36(%r8),%xmm2

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-36(%r9),%xmm9
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpshufb	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpinsrd	$1,-36(%r10),%xmm2,%xmm2
	vpinsrd	$1,-36(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpandn	%xmm12,%xmm10,%xmm7
	vpand	%xmm11,%xmm10,%xmm6

	vmovdqa	%xmm1,96-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpunpckldq	%xmm9,%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-32(%r8),%xmm3

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-32(%r9),%xmm9
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpshufb	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpinsrd	$1,-32(%r10),%xmm3,%xmm3
	vpinsrd	$1,-32(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpandn	%xmm11,%xmm14,%xmm7
	vpand	%xmm10,%xmm14,%xmm6

	vmovdqa	%xmm2,112-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpunpckldq	%xmm9,%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-28(%r8),%xmm4

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-28(%r9),%xmm9
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpshufb	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpinsrd	$1,-28(%r10),%xmm4,%xmm4
	vpinsrd	$1,-28(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpandn	%xmm10,%xmm13,%xmm7
	vpand	%xmm14,%xmm13,%xmm6

	vmovdqa	%xmm3,128-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpunpckldq	%xmm9,%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-24(%r8),%xmm0

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-24(%r9),%xmm9
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpshufb	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpinsrd	$1,-24(%r10),%xmm0,%xmm0
	vpinsrd	$1,-24(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpandn	%xmm14,%xmm12,%xmm7
	vpand	%xmm13,%xmm12,%xmm6

	vmovdqa	%xmm4,144-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpunpckldq	%xmm9,%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-20(%r8),%xmm1

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-20(%r9),%xmm9
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpshufb	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpinsrd	$1,-20(%r10),%xmm1,%xmm1
	vpinsrd	$1,-20(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpandn	%xmm13,%xmm11,%xmm7
	vpand	%xmm12,%xmm11,%xmm6

	vmovdqa	%xmm0,160-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpunpckldq	%xmm9,%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-16(%r8),%xmm2

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-16(%r9),%xmm9
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpshufb	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpinsrd	$1,-16(%r10),%xmm2,%xmm2
	vpinsrd	$1,-16(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpandn	%xmm12,%xmm10,%xmm7
	vpand	%xmm11,%xmm10,%xmm6

	vmovdqa	%xmm1,176-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpunpckldq	%xmm9,%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-12(%r8),%xmm3

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-12(%r9),%xmm9
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpshufb	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpinsrd	$1,-12(%r10),%xmm3,%xmm3
	vpinsrd	$1,-12(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpandn	%xmm11,%xmm14,%xmm7
	vpand	%xmm10,%xmm14,%xmm6

	vmovdqa	%xmm2,192-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpunpckldq	%xmm9,%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-8(%r8),%xmm4

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-8(%r9),%xmm9
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpshufb	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpinsrd	$1,-8(%r10),%xmm4,%xmm4
	vpinsrd	$1,-8(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpandn	%xmm10,%xmm13,%xmm7
	vpand	%xmm14,%xmm13,%xmm6

	vmovdqa	%xmm3,208-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpunpckldq	%xmm9,%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vmovd	-4(%r8),%xmm0

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vmovd	-4(%r9),%xmm9
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpshufb	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vmovdqa	0-128(%rax),%xmm1
	vpinsrd	$1,-4(%r10),%xmm0,%xmm0
	vpinsrd	$1,-4(%r11),%xmm9,%xmm9
	vpaddd	%xmm15,%xmm10,%xmm10
	prefetcht0	63(%r8)
	vpslld	$5,%xmm11,%xmm8
	vpandn	%xmm14,%xmm12,%xmm7
	vpand	%xmm13,%xmm12,%xmm6

	vmovdqa	%xmm4,224-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpunpckldq	%xmm9,%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	prefetcht0	63(%r9)
	vpxor	%xmm7,%xmm6,%xmm6

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	prefetcht0	63(%r10)
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	prefetcht0	63(%r11)
	vpshufb	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vmovdqa	16-128(%rax),%xmm2
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	32-128(%rax),%xmm3

	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpandn	%xmm13,%xmm11,%xmm7

	vpand	%xmm12,%xmm11,%xmm6

	vmovdqa	%xmm0,240-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	128-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1


	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11

	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	48-128(%rax),%xmm4

	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpandn	%xmm12,%xmm10,%xmm7

	vpand	%xmm11,%xmm10,%xmm6

	vmovdqa	%xmm1,0-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	144-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2


	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10

	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	64-128(%rax),%xmm0

	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpandn	%xmm11,%xmm14,%xmm7

	vpand	%xmm10,%xmm14,%xmm6

	vmovdqa	%xmm2,16-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	160-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3


	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14

	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	80-128(%rax),%xmm1

	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpandn	%xmm10,%xmm13,%xmm7

	vpand	%xmm14,%xmm13,%xmm6

	vmovdqa	%xmm3,32-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	176-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4


	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13

	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	96-128(%rax),%xmm2

	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpandn	%xmm14,%xmm12,%xmm7

	vpand	%xmm13,%xmm12,%xmm6

	vmovdqa	%xmm4,48-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	192-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm7,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0


	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12

	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vmovdqa	0(%rbp),%xmm15
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	112-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,64-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	208-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	128-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,80-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	224-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	144-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,96-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	240-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	160-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,112-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	0-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	176-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,128-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	16-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	192-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,144-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	32-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	208-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,160-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	48-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	224-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,176-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	64-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	240-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,192-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	80-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	0-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,208-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	96-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	16-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,224-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	112-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	32-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,240-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	128-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	48-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,0-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	144-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	64-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,16-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	160-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	80-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,32-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	176-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	96-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,48-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	192-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	112-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,64-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	208-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	128-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,80-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	224-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	144-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,96-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	240-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	160-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,112-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	0-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vmovdqa	32(%rbp),%xmm15
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	176-128(%rax),%xmm3

	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpand	%xmm12,%xmm13,%xmm7
	vpxor	16-128(%rax),%xmm1,%xmm1

	vpaddd	%xmm7,%xmm14,%xmm14
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm13,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vmovdqu	%xmm0,128-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm1,%xmm5
	vpand	%xmm11,%xmm6,%xmm6
	vpaddd	%xmm1,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	192-128(%rax),%xmm4

	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpand	%xmm11,%xmm12,%xmm7
	vpxor	32-128(%rax),%xmm2,%xmm2

	vpaddd	%xmm7,%xmm13,%xmm13
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm12,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vmovdqu	%xmm1,144-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm2,%xmm5
	vpand	%xmm10,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	208-128(%rax),%xmm0

	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpand	%xmm10,%xmm11,%xmm7
	vpxor	48-128(%rax),%xmm3,%xmm3

	vpaddd	%xmm7,%xmm12,%xmm12
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm11,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vmovdqu	%xmm2,160-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm3,%xmm5
	vpand	%xmm14,%xmm6,%xmm6
	vpaddd	%xmm3,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	224-128(%rax),%xmm1

	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpand	%xmm14,%xmm10,%xmm7
	vpxor	64-128(%rax),%xmm4,%xmm4

	vpaddd	%xmm7,%xmm11,%xmm11
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm10,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vmovdqu	%xmm3,176-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm4,%xmm5
	vpand	%xmm13,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	240-128(%rax),%xmm2

	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpand	%xmm13,%xmm14,%xmm7
	vpxor	80-128(%rax),%xmm0,%xmm0

	vpaddd	%xmm7,%xmm10,%xmm10
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm14,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vmovdqu	%xmm4,192-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm0,%xmm5
	vpand	%xmm12,%xmm6,%xmm6
	vpaddd	%xmm0,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	0-128(%rax),%xmm3

	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpand	%xmm12,%xmm13,%xmm7
	vpxor	96-128(%rax),%xmm1,%xmm1

	vpaddd	%xmm7,%xmm14,%xmm14
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm13,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vmovdqu	%xmm0,208-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm1,%xmm5
	vpand	%xmm11,%xmm6,%xmm6
	vpaddd	%xmm1,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	16-128(%rax),%xmm4

	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpand	%xmm11,%xmm12,%xmm7
	vpxor	112-128(%rax),%xmm2,%xmm2

	vpaddd	%xmm7,%xmm13,%xmm13
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm12,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vmovdqu	%xmm1,224-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm2,%xmm5
	vpand	%xmm10,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	32-128(%rax),%xmm0

	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpand	%xmm10,%xmm11,%xmm7
	vpxor	128-128(%rax),%xmm3,%xmm3

	vpaddd	%xmm7,%xmm12,%xmm12
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm11,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vmovdqu	%xmm2,240-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm3,%xmm5
	vpand	%xmm14,%xmm6,%xmm6
	vpaddd	%xmm3,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	48-128(%rax),%xmm1

	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpand	%xmm14,%xmm10,%xmm7
	vpxor	144-128(%rax),%xmm4,%xmm4

	vpaddd	%xmm7,%xmm11,%xmm11
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm10,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vmovdqu	%xmm3,0-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm4,%xmm5
	vpand	%xmm13,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	64-128(%rax),%xmm2

	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpand	%xmm13,%xmm14,%xmm7
	vpxor	160-128(%rax),%xmm0,%xmm0

	vpaddd	%xmm7,%xmm10,%xmm10
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm14,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vmovdqu	%xmm4,16-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm0,%xmm5
	vpand	%xmm12,%xmm6,%xmm6
	vpaddd	%xmm0,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	80-128(%rax),%xmm3

	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpand	%xmm12,%xmm13,%xmm7
	vpxor	176-128(%rax),%xmm1,%xmm1

	vpaddd	%xmm7,%xmm14,%xmm14
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm13,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vmovdqu	%xmm0,32-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm1,%xmm5
	vpand	%xmm11,%xmm6,%xmm6
	vpaddd	%xmm1,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	96-128(%rax),%xmm4

	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpand	%xmm11,%xmm12,%xmm7
	vpxor	192-128(%rax),%xmm2,%xmm2

	vpaddd	%xmm7,%xmm13,%xmm13
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm12,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vmovdqu	%xmm1,48-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm2,%xmm5
	vpand	%xmm10,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	112-128(%rax),%xmm0

	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpand	%xmm10,%xmm11,%xmm7
	vpxor	208-128(%rax),%xmm3,%xmm3

	vpaddd	%xmm7,%xmm12,%xmm12
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm11,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vmovdqu	%xmm2,64-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm3,%xmm5
	vpand	%xmm14,%xmm6,%xmm6
	vpaddd	%xmm3,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	128-128(%rax),%xmm1

	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpand	%xmm14,%xmm10,%xmm7
	vpxor	224-128(%rax),%xmm4,%xmm4

	vpaddd	%xmm7,%xmm11,%xmm11
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm10,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vmovdqu	%xmm3,80-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm4,%xmm5
	vpand	%xmm13,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	144-128(%rax),%xmm2

	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpand	%xmm13,%xmm14,%xmm7
	vpxor	240-128(%rax),%xmm0,%xmm0

	vpaddd	%xmm7,%xmm10,%xmm10
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm14,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vmovdqu	%xmm4,96-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm0,%xmm5
	vpand	%xmm12,%xmm6,%xmm6
	vpaddd	%xmm0,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	160-128(%rax),%xmm3

	vpaddd	%xmm15,%xmm14,%xmm14
	vpslld	$5,%xmm10,%xmm8
	vpand	%xmm12,%xmm13,%xmm7
	vpxor	0-128(%rax),%xmm1,%xmm1

	vpaddd	%xmm7,%xmm14,%xmm14
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm13,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vmovdqu	%xmm0,112-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm1,%xmm5
	vpand	%xmm11,%xmm6,%xmm6
	vpaddd	%xmm1,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpaddd	%xmm6,%xmm14,%xmm14

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	176-128(%rax),%xmm4

	vpaddd	%xmm15,%xmm13,%xmm13
	vpslld	$5,%xmm14,%xmm8
	vpand	%xmm11,%xmm12,%xmm7
	vpxor	16-128(%rax),%xmm2,%xmm2

	vpaddd	%xmm7,%xmm13,%xmm13
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm12,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vmovdqu	%xmm1,128-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm2,%xmm5
	vpand	%xmm10,%xmm6,%xmm6
	vpaddd	%xmm2,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpaddd	%xmm6,%xmm13,%xmm13

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	192-128(%rax),%xmm0

	vpaddd	%xmm15,%xmm12,%xmm12
	vpslld	$5,%xmm13,%xmm8
	vpand	%xmm10,%xmm11,%xmm7
	vpxor	32-128(%rax),%xmm3,%xmm3

	vpaddd	%xmm7,%xmm12,%xmm12
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm11,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vmovdqu	%xmm2,144-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm3,%xmm5
	vpand	%xmm14,%xmm6,%xmm6
	vpaddd	%xmm3,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpaddd	%xmm6,%xmm12,%xmm12

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	208-128(%rax),%xmm1

	vpaddd	%xmm15,%xmm11,%xmm11
	vpslld	$5,%xmm12,%xmm8
	vpand	%xmm14,%xmm10,%xmm7
	vpxor	48-128(%rax),%xmm4,%xmm4

	vpaddd	%xmm7,%xmm11,%xmm11
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm10,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vmovdqu	%xmm3,160-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm4,%xmm5
	vpand	%xmm13,%xmm6,%xmm6
	vpaddd	%xmm4,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpaddd	%xmm6,%xmm11,%xmm11

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	224-128(%rax),%xmm2

	vpaddd	%xmm15,%xmm10,%xmm10
	vpslld	$5,%xmm11,%xmm8
	vpand	%xmm13,%xmm14,%xmm7
	vpxor	64-128(%rax),%xmm0,%xmm0

	vpaddd	%xmm7,%xmm10,%xmm10
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm14,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vmovdqu	%xmm4,176-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpor	%xmm9,%xmm8,%xmm8
	vpsrld	$31,%xmm0,%xmm5
	vpand	%xmm12,%xmm6,%xmm6
	vpaddd	%xmm0,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vmovdqa	64(%rbp),%xmm15
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	240-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,192-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	80-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	0-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,208-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	96-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	16-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,224-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	112-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	32-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,240-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	128-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	48-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,0-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	144-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	64-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,16-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	160-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	80-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,32-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	176-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	96-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vmovdqa	%xmm2,48-128(%rax)
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	192-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	112-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vmovdqa	%xmm3,64-128(%rax)
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	208-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	128-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vmovdqa	%xmm4,80-128(%rax)
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	224-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	144-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vmovdqa	%xmm0,96-128(%rax)
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	240-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	160-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vmovdqa	%xmm1,112-128(%rax)
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	0-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	176-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	16-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	192-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	32-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpxor	%xmm2,%xmm0,%xmm0
	vmovdqa	208-128(%rax),%xmm2

	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	48-128(%rax),%xmm0,%xmm0
	vpsrld	$27,%xmm11,%xmm9
	vpxor	%xmm13,%xmm6,%xmm6
	vpxor	%xmm2,%xmm0,%xmm0

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10
	vpsrld	$31,%xmm0,%xmm5
	vpaddd	%xmm0,%xmm0,%xmm0

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm5,%xmm0,%xmm0
	vpor	%xmm7,%xmm12,%xmm12
	vpxor	%xmm3,%xmm1,%xmm1
	vmovdqa	224-128(%rax),%xmm3

	vpslld	$5,%xmm10,%xmm8
	vpaddd	%xmm15,%xmm14,%xmm14
	vpxor	%xmm11,%xmm13,%xmm6
	vpaddd	%xmm0,%xmm14,%xmm14
	vpxor	64-128(%rax),%xmm1,%xmm1
	vpsrld	$27,%xmm10,%xmm9
	vpxor	%xmm12,%xmm6,%xmm6
	vpxor	%xmm3,%xmm1,%xmm1

	vpslld	$30,%xmm11,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm14,%xmm14
	vpsrld	$31,%xmm1,%xmm5
	vpaddd	%xmm1,%xmm1,%xmm1

	vpsrld	$2,%xmm11,%xmm11
	vpaddd	%xmm8,%xmm14,%xmm14
	vpor	%xmm5,%xmm1,%xmm1
	vpor	%xmm7,%xmm11,%xmm11
	vpxor	%xmm4,%xmm2,%xmm2
	vmovdqa	240-128(%rax),%xmm4

	vpslld	$5,%xmm14,%xmm8
	vpaddd	%xmm15,%xmm13,%xmm13
	vpxor	%xmm10,%xmm12,%xmm6
	vpaddd	%xmm1,%xmm13,%xmm13
	vpxor	80-128(%rax),%xmm2,%xmm2
	vpsrld	$27,%xmm14,%xmm9
	vpxor	%xmm11,%xmm6,%xmm6
	vpxor	%xmm4,%xmm2,%xmm2

	vpslld	$30,%xmm10,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm13,%xmm13
	vpsrld	$31,%xmm2,%xmm5
	vpaddd	%xmm2,%xmm2,%xmm2

	vpsrld	$2,%xmm10,%xmm10
	vpaddd	%xmm8,%xmm13,%xmm13
	vpor	%xmm5,%xmm2,%xmm2
	vpor	%xmm7,%xmm10,%xmm10
	vpxor	%xmm0,%xmm3,%xmm3
	vmovdqa	0-128(%rax),%xmm0

	vpslld	$5,%xmm13,%xmm8
	vpaddd	%xmm15,%xmm12,%xmm12
	vpxor	%xmm14,%xmm11,%xmm6
	vpaddd	%xmm2,%xmm12,%xmm12
	vpxor	96-128(%rax),%xmm3,%xmm3
	vpsrld	$27,%xmm13,%xmm9
	vpxor	%xmm10,%xmm6,%xmm6
	vpxor	%xmm0,%xmm3,%xmm3

	vpslld	$30,%xmm14,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm12,%xmm12
	vpsrld	$31,%xmm3,%xmm5
	vpaddd	%xmm3,%xmm3,%xmm3

	vpsrld	$2,%xmm14,%xmm14
	vpaddd	%xmm8,%xmm12,%xmm12
	vpor	%xmm5,%xmm3,%xmm3
	vpor	%xmm7,%xmm14,%xmm14
	vpxor	%xmm1,%xmm4,%xmm4
	vmovdqa	16-128(%rax),%xmm1

	vpslld	$5,%xmm12,%xmm8
	vpaddd	%xmm15,%xmm11,%xmm11
	vpxor	%xmm13,%xmm10,%xmm6
	vpaddd	%xmm3,%xmm11,%xmm11
	vpxor	112-128(%rax),%xmm4,%xmm4
	vpsrld	$27,%xmm12,%xmm9
	vpxor	%xmm14,%xmm6,%xmm6
	vpxor	%xmm1,%xmm4,%xmm4

	vpslld	$30,%xmm13,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm11,%xmm11
	vpsrld	$31,%xmm4,%xmm5
	vpaddd	%xmm4,%xmm4,%xmm4

	vpsrld	$2,%xmm13,%xmm13
	vpaddd	%xmm8,%xmm11,%xmm11
	vpor	%xmm5,%xmm4,%xmm4
	vpor	%xmm7,%xmm13,%xmm13
	vpslld	$5,%xmm11,%xmm8
	vpaddd	%xmm15,%xmm10,%xmm10
	vpxor	%xmm12,%xmm14,%xmm6

	vpsrld	$27,%xmm11,%xmm9
	vpaddd	%xmm4,%xmm10,%xmm10
	vpxor	%xmm13,%xmm6,%xmm6

	vpslld	$30,%xmm12,%xmm7
	vpor	%xmm9,%xmm8,%xmm8
	vpaddd	%xmm6,%xmm10,%xmm10

	vpsrld	$2,%xmm12,%xmm12
	vpaddd	%xmm8,%xmm10,%xmm10
	vpor	%xmm7,%xmm12,%xmm12
	movl	$1,%ecx
	cmpl	0(%rbx),%ecx
	cmovgeq	%rbp,%r8
	cmpl	4(%rbx),%ecx
	cmovgeq	%rbp,%r9
	cmpl	8(%rbx),%ecx
	cmovgeq	%rbp,%r10
	cmpl	12(%rbx),%ecx
	cmovgeq	%rbp,%r11
	vmovdqu	(%rbx),%xmm6
	vpxor	%xmm8,%xmm8,%xmm8
	vmovdqa	%xmm6,%xmm7
	vpcmpgtd	%xmm8,%xmm7,%xmm7
	vpaddd	%xmm7,%xmm6,%xmm6

	vpand	%xmm7,%xmm10,%xmm10
	vpand	%xmm7,%xmm11,%xmm11
	vpaddd	0(%rdi),%xmm10,%xmm10
	vpand	%xmm7,%xmm12,%xmm12
	vpaddd	32(%rdi),%xmm11,%xmm11
	vpand	%xmm7,%xmm13,%xmm13
	vpaddd	64(%rdi),%xmm12,%xmm12
	vpand	%xmm7,%xmm14,%xmm14
	vpaddd	96(%rdi),%xmm13,%xmm13
	vpaddd	128(%rdi),%xmm14,%xmm14
	vmovdqu	%xmm10,0(%rdi)
	vmovdqu	%xmm11,32(%rdi)
	vmovdqu	%xmm12,64(%rdi)
	vmovdqu	%xmm13,96(%rdi)
	vmovdqu	%xmm14,128(%rdi)

	vmovdqu	%xmm6,(%rbx)
	vmovdqu	96(%rbp),%xmm5
	decl	%edx
	jnz	.Loop_avx

	movl	280(%rsp),%edx
	leaq	16(%rdi),%rdi
	leaq	64(%rsi),%rsi
	decl	%edx
	jnz	.Loop_grande_avx

.Ldone_avx:
	movq	272(%rsp),%rax
	vzeroupper
	movq	-16(%rax),%rbp
	movq	-8(%rax),%rbx
	leaq	(%rax),%rsp
	.byte	0xf3,0xc3
.size	sha1_multi_block_avx,.-sha1_multi_block_avx

.align	256
.long	0x5a827999,0x5a827999,0x5a827999,0x5a827999
.long	0x5a827999,0x5a827999,0x5a827999,0x5a827999
K_XX_XX:
.long	0x6ed9eba1,0x6ed9eba1,0x6ed9eba1,0x6ed9eba1
.long	0x6ed9eba1,0x6ed9eba1,0x6ed9eba1,0x6ed9eba1
.long	0x8f1bbcdc,0x8f1bbcdc,0x8f1bbcdc,0x8f1bbcdc
.long	0x8f1bbcdc,0x8f1bbcdc,0x8f1bbcdc,0x8f1bbcdc
.long	0xca62c1d6,0xca62c1d6,0xca62c1d6,0xca62c1d6
.long	0xca62c1d6,0xca62c1d6,0xca62c1d6,0xca62c1d6
.long	0x00010203,0x04050607,0x08090a0b,0x0c0d0e0f
.long	0x00010203,0x04050607,0x08090a0b,0x0c0d0e0f
