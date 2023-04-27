# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 6

# ENUNCIADO:

# Adapte o programa do item 4) para que utilize uma estrutura de iteração 
# tipo while, com critério
# de parada ao encontrar o final da string 
# armazenada usando o caractere \0 (NULL).

.data
	string: .space 8
	inputString: .asciiz "\nInsira a palavra desejada: "
	inputCharacterToCount: .asciiz "\nInsira a letra para contar as ocorrências: "
	resultPrint: .asciiz "\nA quantidade de vezes que a letra apareceu foi: "
.text
.globl main
main:
	la $t6, inputCharacterToCount
	move $a0, $t6
	li $v0, 4
	syscall 
	
	li $v0, 12       
	syscall
	move $s2, $v0    # $s2 contêm a letra escolhida
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
	
	loop:
		lb $s3, ($a0) # Pega da string digitada
		addi $a0, $a0, 1 # Vai pro próx. caracter da string
		addi $t2, $t2, 1 # Controle de número de iterações
		bge $t2, $s4, fim # Se já tiver feito em todos os caracteres, encerra
		bne $s3, $s2, loop # Se o caracter nao for igual ao escolhido, pula
		beq $s3, 0, fim # Se for o caracter nulo, encerra
		addi $t1, $t1, 1 # Se passar por todas as condições, adiciona +1 na contagem de ocorrências
		j loop # Volta pro loop
	fim:
		li $v0, 4 # Printa string
		la $t4, resultPrint # Printa na tela o conteúdo de resultPrint
		move $a0, $t4
		syscall
	
		addi $v0, $t1, 0
		li $v0, 1 # Printa inteiro
		move $a0, $t1 # Bota em $a0 o número de ocorrências
		syscall
		
		li $v0, 10 # Encerra o programa
		syscall
	
	
	
