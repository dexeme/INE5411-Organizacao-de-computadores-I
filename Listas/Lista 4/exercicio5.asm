# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 04 - Exercício 5

# ENUNCIADO:

# A função abaixo, escrita em linguagem C, calcula o fatorial de um número. 
# Implemente um programa em Assembly para o MIPS que:
# – Receba via teclado o valor do número a ser calculado o fatorial;
# – Chame a função fatorial( ) para calcular o fatorial do número;
# – Mostre o resultado na tela do computador.

# Função Fatorial em C:

# int fatorial (int n) {
#	if (n < 1)
#            return 1;
#	else
#	     return (n * fatorial (n - 1));

.data
	defaultPrint: .asciiz "O fatorial vale 1"
	resultPrint: .asciiz "O fatorial é: "
.text
.globl main
main:
	li $v0, 5
	syscall			# Pede input do número = $s0
	move $s0, $v0
	
	li $t0, 1		# $t0 = 1	
	blt $s0, $t0, default   # Se número for < 1 retorna default
	
	move $s1, $s0           # $s1 vai conter o número escolhido
	li $s2, 1               # $s2 vai conter o resultado (inicia em 1)
	jal fatorial
	
	fatorial:
		mul $s2, $s2, $s1    # Resultado = resultado * número
		subi $s1, $s1, 1     # Número -= 1
		beq $s1, $zero, fim  # Se número = 0, sai do loop
		j fatorial	         # Se não, repete o loop
	
	default:
		la $a0, defaultPrint # Imprime default
		li $v0, 4			 
		syscall
		
		j exit
		
	fim:
		la $a0, resultPrint  # Imprime resultado
		li $v0, 4
		syscall
		
		li $v0, 1
		move $a0, $s2 	     # $a0 = resultado = $s2
		syscall 
		j exit
	exit: 
		li $v0, 10		     # Encerra o programa
		syscall
