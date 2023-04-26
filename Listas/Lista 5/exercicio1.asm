# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 1

# ENUNCIADO:

# Escreva um pequeno programa que armazene as seguintes half-words na memória de dados: 1, 2, -2, 3.
# Verifique na memória de dados como esses números foram armazenados.

.data
 	DATA: .half 1 2 -2 3
.text

.globl main

main:
	la $t0, DATA
	lh $s1, 0($t0)
	lh $s2, 2($t0)
	lh $s3, 4($t0)
	lh $s4, 6($t0)
	