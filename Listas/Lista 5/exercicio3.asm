# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 2

# ENUNCIADO:

# Escreva um programa em Assembly do MIPS que receba uma string do teclado 
# com até 7 dígitos e armazene esta string recebida na memória de dados.
# Sugestão: use o comando 8 na chamada de sistema syscall

.data
	string: .space 8
.text

.globl main

main:

	# No nosso caso, queremos no máximo 8 dígitos, ou seja, de acordo
	# com a documentação https://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
	# teremos que fazer n = 8, pois o cálculo feito é máximo = n - 1 
	
	la $t0, string
	move $a0, $t0   # $a0 = address of input buffer
	li $a1, 8	# $a1 = maximum number of characters to read
	li $v0, 8     	
	syscall		
	
	
	
	
	