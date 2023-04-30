# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 06 - Exercício 2

# ENUNCIADO: 

# Implemente um programa que converta a temperatura dada em 
# Fahrenheit via teclado para Celsius. 
# Premissas:
# Utilize a equação de conversão TC/5 = (TF – 32)/9, em que 
# TC é a temperatura em Celsius e TF # em fahreinheit;
# A equação de conversão deve ser implementada como um procedimento.

# TC = ( (TF - 32) * 5 )
#       ---------------
#               9

.data
	asksForInput: .asciiz "Insira a temperatura em Fahrenheit: "
	result: .asciiz "A temperatura em Celsius é: "
	constants: .float 32.0 9.0 5.0
.text
.globl main
main:

	la $a0, asksForInput
	li $v0, 4	       # Printa frase de input
	syscall
	
	li $v0, 6
	syscall		       # Coloca em $f0 a temperatura em Fahrenheit
	mov.s $f1, $f0

	jal convert            # Chava procedimento
	
	j fim		       # Printa resultado
	
	convert:
		
		la $s0, constants
		l.s $f4, 0($s0)	
		l.s $f3, 4($s0)
		l.s $f2, 8($s0)
		
		
		sub.s $f1, $f1, $f4 # (TF - 32)
		div.s $f1, $f1, $f3 # (TF - 32)/ 9
		mul.s $f1, $f1, $f2 # ((TF - 32)/ 9) * 5
		
		jr $ra
	
	fim:
		la $a0, result
		li $v0, 4
		syscall
		
		li $v0, 2
		mov.s $f12, $f1
		syscall
		


