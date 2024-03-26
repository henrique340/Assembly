.data 
	N1: .asciiz "Digite o n�mero para calcular o fatorial: "
	N2: .asciiz "O fatorial �: "
	
.text 
	# Input
	li $v0,4
	la $a0,N1
	syscall 
	
	# Ler input
	li $v0,5
	syscall
	
	# Armazena o input
	move $t0,$v0
	
	# Se for igual a 0 ou 1 � 1
	beq $t0, $zero, fim
	beq $t0, 1, fim
	
	# Vari�vel resultado inicia com 1
	li $t2, 1
	
	# Vari�vel Contador inicia em 1
	li $t1, 1
	
	# Chama fun��o Fatorial
	jal fatorial
	
	
	# Printa N2
	li $v0,4
	la $a0,N2
	syscall
	
	# Printa o resultado
	li $v0, 1
	move $a0, $t2
	syscall
	
	# Fim do programa
	li $v0,10
	
	fatorial:
		# Resultado = Resultado * contador
		mul $t2, $t2, $t1
		
		# Contador aumenta 1
		addi $t1, $t1, 1
		
		# Verifica se alcan�ou o fim
		bne $t1, $t0, fatorial   # Loop
		
		
	fim:
		jr $ra