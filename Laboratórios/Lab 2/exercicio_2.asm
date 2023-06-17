# Alunos: Diana Faustino de Siqueira e Otávio Augusuto de Santana Jatobá

#Dadas as matrizes A e B (abaixo), elabore um programa em Assembly para o processador MIPS (usando o
#simulador MARS) que encontre a matriz resultante do produto: A.B. Armazene a matriz resultante na
#memória de dados.

.data 
	MC:	.word 0, 0, 0 
		  .word 0, 0, 0
		  .word 0, 0, 0 
			
	MA: .word 1, 2, 3 
		  .word 0, 1, 4
		  .word 0, 0, 1
	
	MB:	.word 1, -2, 5
		  .word 0, 1, -4
		  .word 0, 0, 1
		
	.eqv MATRIX_SIZE 3  # Tamanho da matriz
	.eqv DATA_SIZE 4    # Tamanho do tipo
	
	buffer: .space 21    # 3 numeros, 3 espacos e 1 quebra p/ cada linha
	
	out_file: .asciiz "exit.txt"
	
.text
.globl main
main:	
	la $a0, MA # Carrega endereço da matriz A para primeiro argumento da função
	la $a1, MB # Carrega endereço da matriz B para segundo argumento da função
	la $a2, MC # Carrega endereço da matriz C
	jal multiplyMatrix
	
  la $a0, MC          # Endereço da matriz
  la $a1, buffer      # Endereço do buffer
  jal intMatrixToBuffer

  la $a0, out_file    # Endereço do arquivo
  la $a1, buffer      # Endereço do buffer
  li $a2, 21          # Tamanho do buffer          
	jal writeMatrixToFile
	
	# Encerra o processo
	li $v0, 10
	syscall
	
intMatrixToBuffer:
  move $s0, $a0 # s0 = endereco de mC
  move $s1, $a1 # s1 = endereco do buffer

  li $t0, 0         # i = 0
  li $t1, 0         # count = 0

  Loop1:
  li $t3, 0 # j = 0
    
    Loop2:
    mul $t4, $t0, MATRIX_SIZE # t4 = i * MATRIX_SIZE
    add $t4, $t4, $t3   			# t4 += j
    mul $t4, $t4, DATA_SIZE   # t4 *= DATA_SIZE
    add $t4, $t4, $s0 				# t4 += end base de mC
    lb $t5, ($t4)    					# t5 = primeiro byte de mC[t4]
    addi $t5, $t5, 48   			# t5 = codigo ASCII de t5

		add $t4, $s1, $t1 	# t4 = end buffer + count
    sb $t5, ($t4)    		# buffer[count] = t5
		addi $t1, $t1, 1 		# count++

		add $t4, $s1, $t1		# t4 = end buffer + count
    li $t5, 32          # t5 = codigo de espaco em ASCII
    sb $t5, ($t4)    		# buffer[count] = t5 = espaco
    addi $t1, $t1, 1    # count++
    
    addi $t3, $t3, 1    				# j++
    blt $t3, MATRIX_SIZE, Loop2 # if j < 3, loop
    # Loop2 end

  add $t4, $s1, $t1		# t4 = end buffer + count
  li $t5, 10          # t5 = codigo de quebra de linha em ASCII
  sb $t5, ($t4)		    # buffer[count] = t5 = quebra de linha
  addi $t1, $t1, 1    # count++

  addi $t0, $t0, 1    				# i++
  blt $t0, MATRIX_SIZE, Loop1 # if i < 3, loop
  # Loop1 end

  jr $ra

writeMatrixToFile:
  move $s0, $a0
  move $s1, $a1
  move $s2, $a2

	li $v0, 13			  # Carrega a função open file
	move $a0, $s0	    # Endereço do arquivo
	li $a1, 1       	# Abre o arquivo para escrita (1)
	li $a2, 0			    # O mode não é importante
	syscall
	move $s3, $v0		  # Salva o file descriptor em s3
			
	li, $v0, 15		  	# Carrega a função write file
  move $a0, $s3   	# Move o file descriptor para a0
	move $a1, $s1   	# Endereço do buffer de caracteres
  move $a2, $s2   	# Número de caracteres
  syscall
		
  li $v0, 16    		# Carrega a função close file
  move $a0, $s0 		# File descriptor do arquivo a ser fechado
	syscall

  jr $ra

multiplyMatrix:
  move $s0, $a0 # Move o endereço de MA para $s0
  move $s1, $a1 # Move o endereço de MB para $s1
  move $s2, $a2 # Move o endereço de MC para $s2
  li $t5, 0 # i = 0
    LoopI:
    li $t6, 0 # j = 0
      LoopJ:
      li $t7, 0 # k = 0
      li $t8, 0 # cell = z
        LoopK:
        mul $t0, $t5, MATRIX_SIZE	# índiceDaLinha * tamanhoDaColuna 
        add $t0, $t0, $t7 			  # + índiceDaColuna
        mul $t0, $t0, DATA_SIZE 	# * tamanhoDoDado
        add $t0, $t0, $s0 			  # + endereçoBase da matriz MA
        lw $t2, ($t0) 				    # carrega o conteúdo do endereço [i][j]

        mul $t1, $t7, MATRIX_SIZE	# IndexDaColuna * tamanhoDaLinha
        add $t1, $t1, $t6 			  # + índiceDaLinha
        mul $t1, $t1, DATA_SIZE 	# * tamanhoDoDado
        add $t1, $t1, $s1 			  # + endereço base da matriz MB
        lw $t3, ($t1) 				    # carrega o conteúdo do endereço [j][i]

        mul $t2, $t2, $t3 			  # $t2 = MA[i][j] * MB[j][i]
        add $t8, $t8, $t2 			  # cell += $t2

        addi $t7, $t7, 1        	  # k++
        blt $t7, MATRIX_SIZE, LoopK # if k < size, loop

      mul $t4, $t5, MATRIX_SIZE 	# índiceDaLinha * tamanhoDaColuna
      add $t4, $t4, $t6 			    # + índiceDaColuna
      mul $t4, $t4, DATA_SIZE 	  # * tamanhoDoDado
      add $t4, $t4, $s2 			    # + endereçoBase da matriz MC
      sw $t8, ($t4) 				      # mC[i][j] = cell
      
      move $a0, $t8			         	# arg3 = cell
      li $v0, 1					          # print(cell)
      syscall
      
      addi $t6, $t6, 1        	  # j++
      blt $t6, MATRIX_SIZE, LoopJ # if j < size, loop

    addi $t5, $t5, 1        	    # i++
    blt $t5, MATRIX_SIZE, LoopI   # if i < size, loop

  jr $ra
