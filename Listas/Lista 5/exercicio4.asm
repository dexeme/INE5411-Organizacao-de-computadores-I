# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 4

# ENUNCIADO:

# Escreva um programa em Assembly do MIPS que receba uma string do teclado 
# com até 7 dígitos e armazene esta string recebida na memória de dados.
# Sugestão: use o comando 8 na chamada de sistema syscall

.data
	string: .space 8
	inputString: .asciiz "\nInsira a palavra desejada: "
	inputCharacterToCount: .asciiz "\nInsira a letra para contar as ocorrências: "
	resultPrint: .asciiz "\nA quantidade de vezes que a letra apareceu foi: "
.text

.globl main

main:

	# No nosso caso, queremos no máximo 8 dígitos, ou seja, de acordo
	# com a documentação https://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
	# teremos que fazer n = 8, pois o cálculo feito é máximo = n - 1 

	la $t6, inputCharacterToCount
	move $a0, $t6
	li $v0, 4
	syscall 
	
	li $v0, 12       
	syscall
	move $s2, $v0    # $s2 contém a letra escolhida
	li $s4, 8
	
	la $t5, inputString
	move $a0, $t5
	li $v0, 4
	syscall
	
	la $a0, string   # $a0 = address of input buffer
	li $a1, 8	# $a1 = maximum number of characters to read
	li $v0, 8     	
	syscall
	
	li $t1, 0 # Número de vezes que apareceu
	li $t2, 0 # Index atual

	bge $t2, $s4, fim # Se chegou no index, termina programa
	
	loop:
		lb $s3, ($a0) # Pega da string digitada
		bne $s3, $s2, skip # Se o caracter nao for igual ao escolhido, pula
		addi $t1, $t1, 1 # Bota +1 ocorrência
	skip:
		addiu $a0, $a0, 1 # pra ir pro proximo byte
		beq $s3, 0, fim # Se o caracter for o nulo, encerra
		j loop
	fim:
		li $v0, 4
		la $t4, resultPrint
		move $a0, $t4
		syscall
	
		addi $v0, $t1, 0
		li $v0, 1 # Printa inteiro
		move $a0, $t1 # Bota em a0 o número de ocorrências
		syscall
		
		li $v0, 10 # 
		syscall
	
	
	