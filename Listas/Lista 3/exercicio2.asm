# Diana Faustino de Siqueira
# INE5411 – Organizacao de Computadores I
# Lista de Exercicios 03 - Exercicio 2

# ENUNCIADO:

# Faca um programa que calcule o somatório de 1 ate 5, fazendo i++

.data
	result: .word 0
	steps: .word 5
.text
.globl main
main:
	la $t0, result
	lw $t2, ($t0)
	move $a0, $t2
	
	la $t1, steps
	lw $t3, ($t1)
	move $a1, $t3
	
	jal increment
	
increment:
	subi $a1, $a1, 1
	blt $a1, $zero, fim
	addi $a0, $a0, 1
	sw $a0, 4($t0)
	sw $a1, 4($t1)
	j increment
fim:
	li $v0, 10
	syscall
