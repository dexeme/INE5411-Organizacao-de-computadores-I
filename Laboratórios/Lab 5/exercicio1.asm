# Diana Faustino de Siqueira (22102193)
# Otavio Augusto de Santana Jatoba (22100636)

# Exercicio 1 - Laboratorio 5

.data
	.align 4                              # alinha o endereço de mat_a para ser do tamanho de um float
	.eqv MAX 2                            # define MAX como 2
	.eqv LEN 4 							  # define LEN como 4
	.eqv DATA_SIZE 4 				      # define DATA_SIZE como 4
	mat_a: .float 1:LEN 				  # cria matriz A sendo um vetor de floats com tamanho LEN
	mat_b: .float 1:LEN                   # cria matriz B sendo um vetor de floats com tamanho LEN
	
.text
main:
	move $t0, $zero                       # i = 0
	move $t1, $zero	  					  # j = 0
	la $s0, mat_a 					 	  # s0 = endereço de mat_a
	la $s1, mat_b 					      # s1 = endereço de mat_b
	
	loop1_start:
		bge 	$t0, MAX, loop1_end       # se i >= MAX, sai do loop
		move	$t1, $zero                # j = 0
		loop2_start:
			bge		$t1, MAX, loop2_end   # se j >= MAX, sai do loop
			
			# Calculo do deslocamento para matriz A
			mul $t2, $t0, MAX		      # t2 = i * MAX
			add	$t2, $t2, $t1			  # t2 = t2 + j
			mul $t2, $t2, DATA_SIZE 	  # t2 = t2 * DATA_SIZE
			add $t2, $t2, $s0			  # t2 = t2 + end base de mat_a
			
			# Calculo do deslocamento para matriz B
			mul $t3, $t1, MAX 			  # t3 = j * MAX
			add $t3, $t3, $t0			  # t3 = t3 + i
			mul $t3, $t3, DATA_SIZE 	  # t3 = t3 * DATA_SIZE
			add $t3, $t3, $s1			  # t3 = t3 + end base de mat_b
			
			l.s		$f0, 0($t2)	          #	f0 = mat_a[t2] | carrega o valor da celula da matriz A
			l.s		$f1, 0($t3)	          # t5 = mat_b[t3] | carrega o valor da celula da matriz B
			add.s $f2, $f0, $f1           # t6 = t4 + t5   | soma das celulas 
			s.s		$f2, 0($t2)	          # mat_a[t2] = t6 | store do resultado da soma na celula da matriz A
			 
			addi 	$t1, $t1, 1 		  # j++
			j 		loop2_start 		  # volta para o inicio do loop2
		loop2_end:
		
		addi	$t0, $t0, 1 			  # i++
		j 		loop1_start 			  # volta para o inicio do loop1

	loop1_end:  
	exit:
		li $v0, 10                        # encerra o programa
		syscall