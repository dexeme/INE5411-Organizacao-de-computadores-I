# Diana Faustino de Siqueira (22102193)
# Otavio Augusto de Santana Jatoba (22100636)

# Exercicio 2 - Laboratorio 5

.data
	.align 4                              		# alinha o endereço de mat_a para ser do tamanho de um float
	.eqv MAX 4                                  # define MAX como 4
	.eqv LEN 16                                 # define LEN como 16
	.eqv DATA_SIZE 4                            # define DATA_SIZE como 4
	.eqv block_size 2        					# define block_size como 2
	mat_a: .float 1:LEN      					# cria matriz A sendo um vetor de floats com tamanho LEN
	mat_b: .float 1:LEN      					# cria matriz B sendo um vetor de floats com tamanho LEN
	
.text
main:
	move $t0, $zero	     	 					# i = 0
	move $t1, $zero	         					# j = 0
	la $s0, mat_a	         					# s0 = endereço de mat_a
	la $s1, mat_b	         					# s1 = endereço de mat_b
	
	loop1_start:
		bge 	$t0, MAX, loop1_end    			# se i >= MAX, vai para loop1_end
		move	$t1, $zero             			# j = 0
		loop2_start:
			bge $t1, MAX, loop2_end    			# se j >= MAX, vai para loop2_end
			move $t3, $t0              			# t3 = i | ii = i
			
			loop3_start:
				addi	$t4, $t0, block_size    # t4 = i + block_size
				bge 	$t3, $t4, loop3_end     # se ii >= i + block_size, vai para loop3_end
				move 	$t5, $t1                # t5 = j | jj = j
				
				loop4_start:
					# Rotina do loop
					addi  $t6, $t1, block_size  # t6 = j + block_size
					bge $t5, $t6, loop4_end     # se jj >= j + block_size, vai para loop4_end
					
					# Calculo do deslocamento para matriz A
					mul $t7, $t3, MAX           # t7 = ii * MAX 
					add $t7, $t7, $t5           # t7 = t7 + jj
					mul $t7, $t7, DATA_SIZE     # t7 = t7 * DATA_SIZE
					add $t7, $t7, $s0           # t7 = t7 + s0
			
					# Calculo do deslocamento para matriz B
					mul $t8, $t5, MAX           # t8 = jj * MAX
					add $t8, $t8, $t3           # t8 = t8 + ii 
					mul $t8, $t8, DATA_SIZE     # t8 = t8 * DATA_SIZE
					add $t8, $t8, $s1           # t8 = t8 + s1

					# Soma das células das matrizes e store na memória
					l.s	$f0, 0($t7)             # f0 = mat_a[ii][jj] | carrega o valor da célula da matriz A
					l.s	$f1, 0($t8)             # f1 = mat_b[jj][ii] | carrega o valor da célula da matriz B
					add.s $f2, $f0, $f1         # f2 = f0 + f1   | soma das células
					s.s	$f2, 0($t7)             # mat_a[ii][jj] = f2 | store do resultado da soma na célula da matriz A
					
					addi $t5, $t5, 1      	    # jj++
					j loop4_start         	    # volta para loop4_start
				loop4_end:
									
				addi $t3, $t3, 1                # ii++
				j loop3_start                   # volta para loop3_start
			loop3_end:

			addi $t1, $t1, block_size           # j += block_size
			j loop2_start                       # volta para loop2_start
		loop2_end:
		
		addi $t0, $t0, block_size               # i += block_size
		j loop1_start                	        # volta para loop1_start
	loop1_end:
	
	exit:
	li $v0, 10 
	syscall                                     # termina o programa
	
	