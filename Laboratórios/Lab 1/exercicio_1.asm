# Atividade feita em dupla
# Alunos: Diana Faustino de Siqueira e Otávio Augusto de Santana Jatobá

.data 
	var_a: .word 0
	var_b: .word 7
	var_c: .word 0
	var_d: .word 11
	var_e: .word 23
	
.text
.globl main
main:
	
	la $t0, var_a 
	la $t1, var_b
	la $t2, var_c
	la $t3, var_d
	la $t4, var_e
	
	lw $s0, 0($t0) # Carrega no $s0 o valor da variável a
	lw $s1, 0($t1) # Carrega no $s1 o valor da variável b
	lw $s2, 0($t2) # Carrega no $s2 o valor da variável c
	lw $s3, 0($t3) # Carrega no $s3 o valor da variável d
	lw $s4, 0($t4) # Carrega no $s4 o valor da variável e
	
	addi $s0, $s1, 35 # Soma "b" com "35" e coloca em "a"
	sub $s2, $s3, $s0 # Subtrai "d" com "a" e coloca em "c" 
	add $s2, $s2, $s4 # Soma "c" com "e" e coloca em "c"
	
	sw $s2, 0($t2) # Armazena na memória o valor de $s2 na variável "c"