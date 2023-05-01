# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 06 - Exercício 5

# ENUNCIADO:

# Implemente um programa que chame um procedimento
# para calcular as raízes de uma equação
# completa do segundo grau, na forma Ax² + Bx + C = 0. 
# Os coeficientes da equação, todos em ponto
# flutuante de precisão dupla, devem ser informados pelo
# teclado e os valores das raízes devem ser apresentados no monitor.

.data
	constants: .double -4 2 0
	negativeDeltaPrint: .asciiz "Essa equação não possui raízes reais!"
	oneRootPrint: .asciiz "Essa equação só tem 1 raíz real: "
	twoRootsPrint: .asciiz "As duas raízes são: "
	lineBreak: .asciiz "\n"
.text
.globl main
main:
	li $v0, 7
	syscall		 # $f2 -> A
	mov.d $f2, $f0

	li $v0, 7
	syscall		 # $f4 -> B
	mov.d $f4, $f0
	
	li $v0, 7
	syscall		 # $f6 -> C
	mov.d $f6, $f0
	
	# DELTA: B²-4.A.C
	mul.d $f8, $f4, $f4 # B²
	la $t0, constants
	l.d $f10, 0($t0)  # $f10 -> -4
	
	mul.d $f10, $f10, $f2
	mul.d $f10, $f10, $f6    # $f8 -> Delta
	add.d $f8, $f8, $f10
	
	l.d $f22, 16($t0)
	c.lt.d $f8, $f22       # Delta < 0?
	bc1t negativeDelta
	
	# RAÍZES
	# XÂ¹ = -B + sqrt(DELTA)
	#      ----------------
	#             2.A
	# XÂ² = -B - sqrt(DELTA)
	#      ----------------
	#             2.A
	
	mtc1.d $zero, $f12      
	sub.d $f12, $f12, $f4  # $f12 -> - B
	sqrt.d $f14, $f8       # $f14 -> sqrt(delta)
	l.d $f10, 8($t0)       # Carrega o 2 do vetor de constantes
	mul.d $f16, $f10, $f2  # $f16 -> 2.A
	
	
	# ACHANDO X¹
	add.d $f18, $f12, $f14 
	div.d $f18, $f18, $f16   # $f18 -> x¹
	
	c.eq.d $f8, $f22       # Delta = 0?
	bc1t singleRoot
	
	# ACHANDO X²
	sub.d $f20, $f12, $f14
	div.d $f20, $f20, $f16  # $f20 -> x²
	
	j twoRoots
	
	twoRoots:
		la $a0, twoRootsPrint
		li $v0, 4
		syscall
		
		li $v0, 3
		mov.d $f12, $f18
		syscall
		
		la $a0, lineBreak
		li $v0, 4
		syscall
		
		li $v0, 3
		mov.d $f12, $f20
		syscall
		
		j exit
		
	
	singleRoot:
		la $a0, oneRootPrint
		li $v0, 4
		syscall
		
		li $v0, 3
		mov.d $f12, $f18
		syscall
		
		j exit
	
	negativeDelta:
		la $a0, negativeDeltaPrint
		li $v0, 4
		syscall
		j exit
		
	exit:
		li $v0, 10
		syscall
	
	
	
	
