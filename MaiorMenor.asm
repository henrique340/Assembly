.data 
	N1: .asciiz "Digite o primeiro numero: "
	N2: .asciiz "Digite o segundo numero: "
	N3: .asciiz "Digite o terceiro numero: "
	Maior: .asciiz "Maior valor: "
	Medio: .asciiz "Valor intermediario: "
	Menor: .asciiz "Menor valor: "
.text
	# Primeiro input
	li $v0,4
	la $a0,N1
	syscall
	
	li $v0,5
	syscall 
	
	move $t0, $v0
	
	# Segundo input
	li $v0,4
	la $a0,N2
	syscall
	
	li $v0,5
	syscall 
	
	move $t1, $v0
	
	# Terceiro input
	li $v0,4
	la $a0,N3
	syscall
	
	li $v0, 5
	syscall 
	
	move $t2, $v0
	
	
	bgt $t0, $t1, t0t1
	bgt $t1,$t2, t1t2
	j t2t1t0
	
	t0t1: 
		bgt $t1, $t2, t0t1t2
		bgt $t0, $t2, t0t2t1
		j t2t0t1
	t1t2:
		bgt $t2, $t0, t1t2t0
		bgt $t1, $t0, t1t0t2
		
		
	t0t1t2:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t2
		syscall
	
		j fim
		
	t0t2t1:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t1
		syscall
	
		j fim
		
	t1t2t0:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t0
		syscall
	
		j fim
		
	t1t0t2:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t2
		syscall
	
		j fim
	t2t1t0:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t1
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t0
		syscall
	
		j fim
		
	t2t0t1:
		li $v0, 4
		la $a0,Maior
		syscall 
		
		move $a0, $t2
		syscall
		
		li $v0, 4
		la $a0,Medio
		syscall
		
		move $a0, $t0
		syscall
		
		li $v0, 4
		la $a0,Menor
		syscall
		
		move $a0, $t1
		syscall
	
		j fim
	
	
	fim: 
		li $v0,10
		syscall
		