.data 
	Menu: .asciiz "\n1 Soma\n2 Subtracao\n3 Multiplicacao\n4 Divisao\n5 Sair\nEscolha a operacao: "
	Primeiro: .asciiz "Digite o primeiro numero: "
	Segundo: .asciiz "Digite o segundo numero: "
	Resposta: .asciiz "Resposta = "
	Restricao: .asciiz "O numero 0 nao pode ser divisor"
.text 
	main:
	# Imprimir Menu
	li $v0, 4
	la $a0, Menu
	syscall
	
	# Ler o input
	li $v0, 5
	syscall
	move $t0, $v0
	
	# Definir valores
	li $s0, 1
	li $s1, 2
	li $s2, 3
	li $s3, 4
	li $s4, 5
	
	# Comparações 
	beq $t0, $s0, um # Se input = 1
	beq $t0, $s1, dois # Se input = 2
	beq $t0, $s2, tres # Se input = 3
	beq $t0, $s3, quatro # Se input = 4
	beq $t0, $s4, cinco # Se input = 5
	j main
	
	um: #Soma
		# Primeiro input
		li $v0, 4
		la $a0,Primeiro
		syscall
		
		li $v0, 5
		syscall
		
		move $t1, $v0
		
		# Segundo input
		li $v0, 4
		la $a0,Segundo
		syscall
		
		li $v0, 5
		syscall
		
		move $t2, $v0
		
		add $t3, $t2, $t1
		
		li $v0, 4
		la $a0, Resposta
		syscall
		
		li $v0,1
		move $a0, $t3
		syscall
		
		j main
		
	dois: # Subtração
		# Primeiro input
		li $v0, 4
		la $a0,Primeiro
		syscall
		
		li $v0,5
		syscall
		
		move $t1, $v0
		
		# Segundo input
		li $v0, 4
		la $a0,Segundo
		syscall
		
		li $v0, 5
		syscall
		
		move $t2, $v0
		
		sub $t3, $t1, $t2
		
		li $v0, 4
		la $a0, Resposta
		syscall
		
		li $v0,1
		move $a0, $t3
		syscall
		
		j main
		
	tres: #Multiplicação
		# Primeiro input
		li $v0, 4
		la $a0,Primeiro
		syscall
		
		li $v0, 5
		syscall
		
		move $t1, $v0
		
		# Segundo input
		li $v0, 4
		la $a0,Segundo
		syscall
		
		li $v0, 5
		syscall
		
		move $t2, $v0
		
		mul $t3, $t2, $t1
		
		li $v0, 4
		la $a0, Resposta
		syscall
		
		li $v0,1
		move $a0, $t3
		syscall
		
		j main
		
	quatro: # Divisão
		# Primeiro input
		li $v0, 4
		la $a0,Primeiro
		syscall
		
		li $v0,5
		syscall
		
		move $t1, $v0
		
		# Segundo input
		li $v0, 4
		la $a0,Segundo
		syscall
		
		li $v0,5
		syscall
		
		move $t2, $v0
		
		# Restrição do zero no divisor
		beq $t2, $zero, erro
		
		div $t3, $t1, $t2
		
		li $v0, 4
		la $a0, Resposta
		syscall
		
		li $v0,1
		move $a0, $t3
		syscall
		
		j main
		
	cinco: 
		li $v0, 10 # Fim do programa
		syscall
	
	erro: 
		li $v0,4
		la $a0, Restricao
		syscall
		
		j main
		