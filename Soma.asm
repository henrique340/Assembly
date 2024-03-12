.data 
	N1: .asciiz "Digite o primeiro numero: "
	N2: .asciiz "Digite o segundo numero: "
	Resposta: .asciiz "Resposta: "
	
.text
	# Imprimir N1
	li $v0,4
	la $a0,N1
	syscall
	
	# Ler um int do input
	li $v0,5
	syscall
	
	# Cópia do dado lido
	move $t0, $v0
	
	# Imprimir N2
	li $v0,4
	la $a0,N2
	syscall
	
	# Ler o segundo input
	li $v0,5
	syscall
	
	# Cópia do dado lido
	move $t1, $v0
	
	# Soma
	add $t2, $t1, $t0
	
	# Imprimir Resposta
	li $v0,4
	la $a0,Resposta
	syscall
	
	#Imprimir o resultado na tela
	li $v0,1
	move $a0, $t2
	syscall