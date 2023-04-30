# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 06 - Exercício 3

# ENUNCIADO:

# Escreva um programa que receba dois valores inteiros 
# S e C, calcule e exiba a média: MEDIA = S (float) / C (float)
# como um número de ponto flutuante de precisão simples. 
# Dica: use a instrução de conversão adequada para 
# converter S e C de palavras inteiras em flutuação de
# precisão simples.

.data
.text
.globl main
main:
	li $v0, 5
	syscall		     # S
	move $s0, $v0
	
	li $v0, 5
	syscall		     # C
	move $s1, $v0
	
	mtc1 $s0, $f0
	mtc1 $s1, $f1        # Converte para precisão simples
	cvt.s.w $f0, $f0
	cvt.s.w $f1, $f1
	
	div.s $f2, $f0, $f1  # S / C
	
	
	
	
	
	
	
	