.data 
	N1: .asciiz "Digite o primeiro numero: "
	N2: .asciiz "Digite o segundo numero: "
	N3: .asciiz "Digite o terceiro numero: "
	Maior: .asciiz "\nMaior valor: "
	Medio: .asciiz "\nValor intermediario: "
	Menor: .asciiz "\nMenor valor: "
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
	
	# Comparações
	
	bgt $t0, $t1, Se_t0_maior_t1                 # Se t0 > t1
	bgt $t0, $t2, t1_maior_t0_maior_t2           # Senão Se t0 > t2
	bgt $t1, $t2, t1_maior_t2_maior_t0           # Senão Se t1 > t2
	j t2_maior_t1_maior_t0                       # Senão
	
	# Funções 
	Se_t0_maior_t1:				     # Se t0 > t1
		bgt $t1, $t2, t0_maior_t1_maior_t2   # Senão Se t1 > t2
		bgt $t0, $t2, t0_maior_t2_maior_t1   # Senão Se t0 > t2
	t2_maior_t0_maior_t1:			     # Senão 
		li $v0, 4
		la $a0, Maior
		syscall
		move $a0,$t2
		li $v0,1
		syscall
		
		li $v0, 4
		la $a0, Medio
		syscall
		move $a0, $t0
		li $v0, 1
		syscall
		
		li $v0,4
		la $a0, Menor
		syscall
		move $a0, $t1
		li $v0, 1
		syscall
		
		j Fim
	
	t0_maior_t1_maior_t2:   
		li $v0, 4
		la $a0,Maior
		syscall
		move $a0, $t0
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Medio
		syscall
		move $a0, $t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Menor
		syscall
		move $a0, $t2
		li $v0,1
		syscall
	
		j Fim
	
	t0_maior_t2_maior_t1:
		li $v0,4
		la $a0,Maior
		syscall
		move $a0, $t0
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Medio
		syscall
		move $a0, $t2
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Menor
		syscall
		move $a0, $t1
		li $v0,1
		syscall

		j Fim

	t1_maior_t0_maior_t2: 
		li $v0,4
		la $a0,Maior
		syscall 
		move $a0,$t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Medio
		syscall
		move $a0,$t0
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Menor
		syscall
		move $a0,$t2
		li $v0,1
		syscall
		
		j Fim
		
	t1_maior_t2_maior_t0:
		li $v0,4
		la $a0,Maior
		syscall 
		move $a0,$t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Medio
		syscall
		move $a0,$t2
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Menor
		syscall
		move $a0, $t0
		li $v0,1
		syscall
		
		j Fim
		
	t2_maior_t1_maior_t0:
		li $v0,4
		la $a0,Maior
		syscall 
		move $a0,$t2
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Medio
		syscall
		move $a0,$t1
		li $v0,1
		syscall
		
		li $v0,4
		la $a0,Menor
		syscall
		move $a0, $t0
		li $v0,1
		syscall
	
	Fim:
		li $v0,10
		syscall
	
		