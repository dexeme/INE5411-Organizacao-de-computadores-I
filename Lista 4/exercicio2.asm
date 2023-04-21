# Diana Faustino de Siqueira
# INE5411 – Organização de Computadores I
# Lista de Exercícios 04 - Exercício 2

# ENUNCIADO:

# Implemente em Assembly do MIPS o código abaixo, escrito em linguagem C:

# int CalculaAreaQuadrado (int h, int w){
# 	int area = h * w;
# 	return area;
# }

# int main(){
# 	int a = 4;
# 	int b = 10;
# 	int area = CalculaAreaQuadrado(a, b);
# 	return 0;
# }

.data

.text

.globl main
main:
	li $a0, 4 # Carrega o valor 4 no registrador $a0
	li $a1, 10 # Carrega o valor 10 no registrador $a1
	
	jal calculaAreaQuadrado # Chama o procedimento calculaAreaQuadrado
	
	j fim # Depois de executar o procedimento, vai para o fim
	
calculaAreaQuadrado:
	mul $s0, $a0, $a1 # Multiplica os valores de $a0 e $a1 e armazena o resultado em $s0
	jr $ra  # Retorna ao procedimento chamador

fim:
	li $v0, 10 # Encerra o programa
	syscall
	
	
	