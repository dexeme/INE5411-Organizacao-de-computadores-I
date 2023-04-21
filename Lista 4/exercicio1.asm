# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 04 - Exercício 1

# ENUNCIADO:

# Escreva um programa em Assembly do MIPS que implemente a função escrita em alto nível
# apresentada abaixo. 

# int calcula(int g, int h, int i, int j) {
# 	int f;
# 	f = (g + h) – (i + j);
# 	return f;
# }

# Considere que:
#  – Os valores de g, h, i, j devem ser números inteiros informados pelo usuário via teclado;
#  – Os valores lidos (g, h, i, j) e o valor calculado (f) devem ser armazenados em memória;
#  – A função calcula() deverá ser implementada como um procedimento no Assembly do MIPS.

.data
	f: .word 0
.text 
.globl main
main:

	la $t0, f	    # Carrega endereco de f p/ $t0

	li $v0, 5
	syscall
	move $a0, $v0       # Carrega g para $a0
	sw $a0, 4($t0) 
	
	li $v0, 5
	syscall
	move $a1, $v0       # Carrega h para $a1
	sw $a1, 8($t0) 

	li $v0, 5
	syscall		    # Carrega i para $a2
	move $a2, $v0
	sw $a2, 12($t0) 

	li $v0, 5
	syscall
	move $a3, $v0	    # Carrega j para $a3
	sw $a3, 16($t0)
	
	jal calcula
	
	j fim
	
	calcula:
		lw $s0, 0($t0) # Carrega f para $s0
		lw $t1, 4($t0) # Carrega g para $t1
		lw $t2, 8($t0) # Carrega h para $t2
		lw $t3, 12($t0) # Carrega i para $t3
		lw $t4, 16($t0) # Carrega j para $t4
		
		add $t1, $t1, $t2
		add $t3, $t3, $t4
		sub $s0, $t1, $t3
		
		sw $s0, 0($t0)
		
		jr $ra
	
	fim:
		li $v0, 10    # Encerra programa
		syscall
	
	