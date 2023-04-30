# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 06 - Exercício 1

# ENUNCIADO:

# Considere que o valor de π (pi) seja 3.141592653589793. 
# Crie um programa que calcule a área de um círculo. 
# O usuário deverá informar o raio do círculo via teclado.

# Área do círculo: pi*Raio^2

.data
	pi: .double 3.141592653589793
	asksForRadius: .asciiz "Insira o raio do círculo: "
	result: .asciiz "A área do círculo é: "
.text
.globl main
main:
	la $a0, asksForRadius 
	li $v0, 4                   # Printa pergunta
	syscall
	
	li $v0, 7 
	syscall			    # Lê valor do raio (float)
	mov.d $f2, $f0              # Move pro $f3 o valor lido 
	
	mfc1 $t2, $f2		    # Coloca #f3 no registrador comum $t2
	blt $t2, 0, main            # Se raio < 0, pede novamente input
	
	la $t0, pi		    # Carrega endereço do pi
	l.d $f4, ($t0)              # Lê float de precisão simples
	
	mul.d $f6, $f0, $f0           # Raio² | Multiplicação entre precisão simples
	mul.d $f6, $f6, $f4           # Raio² * pi
	
	la $a0, result
	li $v0, 4                   # Printa "A área do círculo é: "
	syscall
	
	mov.d $f12, $f6             # $f12 é o registrador do float a ser impresso
	li $v0, 3	            # Printa double
	syscall
	
	
	

	
	