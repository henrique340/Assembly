.data 
	Resposta: .asciiz "O resultado = "
.text
	li $s0, 7
	li $s1, 7
	beq $s0, $s1, inst
	add $s2, $s0, $s1
	j fim
	inst: sub $s2, $s0, $s1
	fim:
	# Imprimir "o resultado = "
	li $v0,4
	la $a0, Resposta
	syscall
	
	# Mostrar a resposta
	li $v0, 1
	move $a0, $s2
	syscall
	