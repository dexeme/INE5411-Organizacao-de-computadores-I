# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 03 - Exercício 3

# ENUNCIADO:

# Faça um programa que carregue o vetor v=[1,3,2,1,4,5] para a memória. Ou seja, que contenha a
# sequência de instruções MIPS correspondentes às instruções C seguintes:
# v[0] = 1;
# v[1] = 3;
# v[2] = 2;
# v[3] = 1;
# v[4] = 4
# v[5] = 5;
# Assuma que o registrador $s0 contém o endereço de início do vetor como sendo 0x10010020.

.data 0x10010020
	vetor: .space 24
.text
.globl main
main:
	la $s0, 0x10010020
	li $t0, 1
	sw $t0, ($s0)
	sw $t0, 12($s0)
	li $t0, 3
	sw $t0, 4($s0)
	li $t0, 2
	sw $t0, 8($s0)
	li $t0, 4
	sw $t0, 16($s0)
	li $t0, 5
	sw $t0, 20($s0)



