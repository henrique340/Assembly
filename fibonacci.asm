.data 
# Nome: Andr� Moreira Guimar�es        RA: 10416590
# Nome: Henrique Yuji Isogai Yoneoka   RA: 10418153

menu: .asciiz "Digite a quantidade de termos de fibonacci: "
virgula: .asciiz ","

.text
li $v0, 4  # imprimir menu
la $a0, menu
syscall

li $v0, 5  # ler numero
syscall
move $t0, $v0  # armazena numero em $t0 / contador decrescente

# Inicializa os dois primeiros termos
li $t1, 0	# primeiro termo
li $t2, 1	# segundo termo

beq $t0, 1,  excecao

# Imprimir os dois primeiros termos da sequ�ncia com v�rgula
li $v0,1
move $a0,$t1
syscall
li $v0,4
la $a0,virgula
syscall
li $v0,1
move $a0,$t2
syscall



addi $t0, $t0, -2	# Contador -= 2
beq $t0, $zero, fim	# Finaliza o programa se n�o tiver mais termos

# Fun��o Fibonacci
fibonacci:
	# Calcula o pr�ximo termo
    	add $t3, $t1, $t2    # $t3 = $t1 + $t2
   	move $t1, $t2        # $t1 = $t2
    	move $t2, $t3        # $t2 = $t3

    	# Imprimir o termo atual da sequ�ncia de Fibonacci com virgula
    	li $v0, 4
    	la $a0, virgula
    	syscall
    	li $v0, 1            
    	move $a0, $t2       
    	syscall

    	addi $t0, $t0, -1	# contador -= 1
    	bnez $t0, fibonacci	# Se contador != 0, continua o loop
j fim

excecao:	# imprime o 0 para fazer a exce��o de 1 termo
li $v0,1
move $a0, $zero
syscall

fim:
	li $v0,10
	syscall