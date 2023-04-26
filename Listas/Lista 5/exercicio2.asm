# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 05 - Exercício 2

# ENUNCIADO:

# Implemente o código abaixo e verifique o resultado final nos registradores $t0 e $t1:

# Código em questão:

.data                 #0 1 2  3   4    -> Indo de byte em byte
	ENTRADA: .byte 1 2 -2 -3 -4
.text

.globl main
main:
	la $s2, ENTRADA
	lb $t0, 2($s2)
	lbu $t1, 3($s2)
loop:
	j loop


# RESPOSTA: Os registradores $t0 e $t1 ficaram com resultado final armazenado -2 e 253, respectivamente
# O 253 se dá pelo fato de que em complemento de dois temos 256 bits (255 + 1 de sinal) e como nosso número
# é o -3 (com sinal), teremos 256 - 3 = 253
# Se fosse um número positivo, ele sairia igual e não haveria esse cálculo
# O -2 no registrador $t0 é pelo fato de que como nossa ENTRADA é um vetor de bytes, acessamos esses endereços
# de 1 em 1, resultando no segundo elemento do vetor, que é o -2
