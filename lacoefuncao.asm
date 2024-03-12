.data 
	Texto: .asciiz "\nFim!"
.text
	j main
	
	funcao:
	li $s0, 10
	li $s1, 1
	
	laco:
	beq $s0, $s1, fimlaco
	add $s2, $s2, $s1 #s2 = s2 + s1
	sub $s0, $s0, $s1 #s0 = s0 - s1
	j laco
	fimlaco:
	jr $ra
	
	main:
	li $s2, 10
	jal funcao
	
	li $v0, 1
	move $a0, $v0
	syscall
	
	li $v0, 4
	la $a0,Texto
	syscall