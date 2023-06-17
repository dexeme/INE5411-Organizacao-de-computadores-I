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
	
.text
.globl main
main:	
	la $a0, MA # Carrega endereço da matriz A para primeiro argumento da função
	la $a1, MB # Carrega endereço da matriz B para segundo argumento da função
	la $a2, MC # Carrega endereço da matriz C
	jal multiplyMatrix
	
	li $v0, 10 # Carrega a função de encerrar processo
	syscall    # Encerra o processo

# LINHA PRINCIPAL -> endereço = endereçoBase + (índiceDaLinha * tamanhoDaColuna 
# + índiceDaColuna) * tamanhoDoDado
	
# COLUNA PRINCIPAL -> endereço = endereçoBase + (IndexDaColuna * tamanhoDaLinha 
# + ÍndiceDaLinha) * tamanhoDoDado

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
