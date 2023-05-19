# Laboratório 3 - Organização de Computadores
# Alunos: Diana Faustino de Siqueira e Fabrício Duarte Júnior

# Exercício 2

.data
	matriz: .space 256 # Aloca na memória os 256 elementos
.text
	la $t0, matriz # Carrega endereço da matriz
	li $s0, 0  # value = 0
	li $t1, 0  # $t1 = row = 0
for_i:
	beq $t1, 16, for_i_end # Se row == 16, sai do loop
	li $t2, 0 # $t2 = col = 0
for_j:
	beq $t2, 16, for_j_end # Se col == 16, sai do loop
	
	# Cálculo do endereço da matriz
	mul $t4, $t2, 4 # $t4 = col * 4
	mul $t3, $t1, 64 # $t3 = row * 64
	add $t3, $t3, $t4 # $t3 = row * 64 + col * 4
	add $t3, $t3, $t0 # $t3 = matriz + row * 64 + col * 4
	
    # Armazena o valor na matriz
	sw $s0, 0($t3) # matriz[row][col] = value
	addi $s0, $s0, 1 # value++
	
	addi $t2, $t2, 1 # col++
	j for_j # Volta para o início do loop

for_j_end:
	addi $t1, $t1, 1 # row++
	j for_i # Volta para o início do loop
    
for_i_end: