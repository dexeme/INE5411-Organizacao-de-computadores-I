# Diana Faustino de Siqueira
# INE5411 â€“ OrganizaÃ§Ã£o de Computadores I
# Lista de ExercÃ­cios 04 - ExercÃ­cio 3

# ENUNCIADO:

# A funÃ§Ã£o abaixo, escrita em linguagem C, calcula a potÃªncia de um 
# nÃºmero (N^M).

# int pow(int N, int M){
# 	int i, res = 1;
# 	for(i = 1; i <= M; i++){
# 		res = res * N;
# 	}
# 	return res;
# }

# Implemente um programa em Assembly para o MIPS que:
# â€“ Receba os valores de Base e Expoente via teclado;
# â€“ Chame a funÃ§Ã£o pow() para calcular a potÃªncia do nÃºmero;
# â€“ Mostre o resultado na tela do computador.
.data
	aux: .word 1
	res: .word 1
	textoPrint: .asciiz "O resultado eh " 
.text
.globl main
main:
	li, $v0, 5
	syscall              # Le input N Numero
	move $a0, $v0
	
	li, $v0, 5
	syscall		     # Le input M Expoente
	move $a1, $v0
	
	la $t3, aux
	lw $t4, ($t3)        # Res = 1
	move $a2, $v0
	
	jal pow
	
	j fim
	
	pow:
  		la $t5, res         # Carrega endereço de memória da nova variável "res"
  		lw $t2, ($t5)       # Carrega o valor atual do resultado parcial
  		beq $a1, $zero, fim
  		subi $a1, $a1, 1
  		mul $t2, $t2, $a0   # Usa $t2 em vez de $a2 para armazenar o resultado parcial
  		sw $t2, ($t5)       # Armazena o resultado parcial na nova variável "res"
  		j pow
	fim:
		li $v0, 4
		la $a0, textoPrint
		syscall
		move $a0, $a2   # Move o resultado do cálculo para o registrador $a0
		li $v0, 1
		syscall
		li $v0, 10
		syscall
	
	
	
	
	
	
	
