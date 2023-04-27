# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 7

# ENUNCIADO:

#Considere que o processador MIPS está sendo utilizado para controlar 
# um conjunto de 32 dispositivos externos. 
# Cada dispositivo recebe um bit indicando 
# se ele deve ser ligado (=1) ou desligado (=0). 
# Estes bits estão armazenados no endereço de dados 0x10010020. 
# Implemente um programa que faça as seguintes operações:
# 1 - O usuário deve informar pelo teclado se quer ligar ou desligar um bit. 
# Exemplo: se digitar 1, é para ligar algum bit. 
# Se digitar 0, é para desligar algum bit;
# 2 - O usuário deve informar, na sequência, qual bit deve ser ligado/desligado.
# Por exemplo, ao digitar 2, então o bit 2 do endereço 0x10010020
# deve ser ligado ou desligado (conforme instrução anterior).
# 3 - Os estados anteriores dos outros bits devem ser preservados obrigatoriamente.

.data 0x10010020
	maquina: .word 1
.text
.globl main
main:
	li $s0, 1 # $s0, máscara de bits toda 1
	li $v0, 5 # Lê inteiro
	syscall
	move $s1, $v0 # Coloca em $s1 (desligar/ligar) bit
	
	la $t0, maquina
	
	
	inputOnOff:
		li $v0, 5 # Lê inteiro
		syscall
		move $s1, $v0 # Coloca em $s1 (desligar/ligar) bit
		# Verifica se o valor digitado é válido
		beq $s1, 0, desligarBit
		beq $s1, 1, ligarBit
		j inputOnOff
	
	desligarBit:
		li $v0, 5 # Pergunta que bit quer desligar
		syscall
		move $s2, $v0 # Coloca em $s2 o bit a ser desligado
		blt $s2, 0, desligarBit # Input inválido bit < 0
		bgt $s2, 31, desligarBit # Input inválido bit > 32
		lw $t1, 0($t0) # Carrega máquina
		sllv $s0, $s0, $s2 #
		not $s0, $s0
		and $t1, $t1, $s0 # Desliga bit específico
		sw $t1, 0($t0) # Guarda na memória de novo
		j printaResultado
		
	ligarBit:
		li $v0, 5 # Pergunta que bit quer ligar
		syscall
		move $s3, $v0 # Coloca em $s3 o bit a ser ligado
		blt $s2, 0, ligarBit # Input inválido bit < 0
		bgt $s2, 31, ligarBit # Input inválido bit > 32
		
		
	printaResultado:
		li $v0, 1
		move $a0, $t1
		syscall
		
		li $v0, 10
		syscall
		
	
	
	
	
	
	
	
	
	
