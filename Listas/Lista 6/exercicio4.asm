# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 06 - Exercício 4

# ENUNCIADO:

# Implemente um programa que chame um procedimento 
# para calcular a raiz de uma equação completa do 
# primeiro grau, na forma Ax + B = 0. Os coeficientes, todos 
# em ponto flutuante de precisão simples, devem ser 
# informados pelo teclado. 
# O valor da raiz deve ser apresentado no monitor.

.data
.text
.globl main
main:
	li $v0, 6
	syscall		 # $f1 -> A
	mov.s $f1, $f0
	
	li $v0, 6
	syscall          # $f2 -> B
	mov.s $f2, $f0	 
	
	jal calc
	
	j result
	
	calc:
		mtc1 $0, $f3        
		sub.s $f2, $f3, $f2 # Inverte sinal do B | (0 - B)
		
		div.s $f3, $f2, $f1 # B / A
		
		jr $ra              # Volta pra linha que o chamou
	
	result:
		li $v0, 2
		mov.s $f12, $f3	    # Printa resultado
		syscall	
		
		
		
		
		
		
	
	