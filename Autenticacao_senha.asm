.data 
	Senha1: .word 12345678
	Senha2: .asciiz "\nDigite a sua senha: "
	SenhasIguais: .asciiz "Voce foi autenticado corretamente!"
	SenhasDiferentes: .asciiz "Autenticacao falhou\nTente novamente" 

.text
main:
	# Imprimir Digite a sua senha: 
	li $v0,4
	la $a0,Senha2
	syscall
	
	# Ler senha do input
	li $v0,5
	syscall
	
	# Armazena a senha do input
	move $t1, $v0
	
	# Armazena a senha original
	lw $t0, Senha1
	
	# Comparar se as duas senhas são iguais com operações bit a bit
	xor $t2, $t1, $t0   # se forem iguais retorna 0
	beq $t2, $zero, igual
	
	# Imprir o erro na autenticação
	li $v0, 4
	la $a0, SenhasDiferentes
	syscall
	j main
	
	igual:
		# Imprimir você foi autenticado corretamente
		li $v0, 4
		la $a0, SenhasIguais
		syscall
		
		# Encerra o programa
		li $v0, 10
		syscall
