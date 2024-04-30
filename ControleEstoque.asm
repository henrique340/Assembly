.data 
	Menu: .asciiz "\n[1] Inserir um novo item no estoque\n[2] Excluir um item do estoque\n[3] Buscar um item pelo c�digo\n[4] Atualizar quantidade em estoque\n[5] Imprimir os produtos em estoque\n[6] Sair\nOpcao:"
	Erro: .asciiz "Opcao Invalida"
	CodigoProduto: .asciiz "Digite o codigo do produto: "
	QuantidadeProduto: .asciiz "Digite a quantidade do produto: "
	ExcluirProduto: .asciiz "Digite o codigo do produto a ser excluido: "
	ProdutoExcluido: .asciiz "Produto excluido com sucesso!"
	ListaVazia: .asciiz "A lista esta vazia"
.text
imprimir_menu:
	# Imprimir o Menu
	li $v0,4
	la $a0, Menu
	syscall
	j main
	

inserir_item:
	# Input do c�digo
	li $v0, 4
	la $a0, CodigoProduto
	syscall
	li $v0,5
	syscall
	move $t1, $v0  # Armazena o codigo em $t1
	
	# Input da quantidade
	li $v0, 4
	la $a0, QuantidadeProduto
	syscall
	li $v0, 5
	syscall
	move $t2, $v0  # Armazena a quantidade em $t2

	# Criar um novo n�
	li $v0, 9  # Alocando mem�ria no Heap
	li $a0, 12  # 4 bytes para o c�digo, 4 para a quantidade, 4 para o next
	syscall
	move $t3, $v0  # Armazenando o endere�o do novo n�
	
	# Armazenar o c�digo no endere�o do n�
	sw $t1, 0($t3)
	
	# Armazenar a quantidade no endere�o do n�
	sw $t2, 4($t3)
	
	# Se lista_vazia (head == null), novo n� vira o head
	beq $s0, $zero, lista_vazia
	move $t4, $s0                  # $t4 recebe o endere�o no head
	loop:
		lw $t1, 8($t4)         # Carrega o next do n� atual
		beqz $t1, saida_loop   # Se (next == null) fim do loop
		move $t4, $t1          # Pr�ximo n�
		j loop
	saida_loop:	
	# Conectando o novo n� ao final da lista
	sw $t3, 8($t4)
	jr $ra

excluir_item:
	# Se a lista est� vazia
	beq $s0, $zero, lista_excluir_vazia

	# Solicita��o do c�digo pelo usu�rio
	li $v0, 4
	la $a0, ExcluirProduto
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	# inicializando os registradores
	move $t2, $s0    # $t2 recebe o endere�o do n� atual
	move $t3, $zero  # $t3 recebe o endere�o do n� anterior

loop_excluir:
	beqz $t2, lista_excluir_vazia  # Sai do loop quando chegar ao final da lista
	
	# Carregando o c�digo
	lw $t4, 0($t2)
	
	# Se o c�digo for igual ao input
	beq $t4, $t1, encontrado
	
	# atualizar endere�os
	move $t3, $t2          # $t3 = $t2
	lw $t2, 4($t2)         # $t2 avan�a para o pr�ximo n�
	j loop_excluir

encontrado:
	# Se o n� a ser exclu�do � o head
	beq $t3, $zero, atualizar_head
	
	# Se o n� a ser excluido n�o � o head
	sw $t2, 8($t3)         # Apontar o next n� anterior para o next do n� atual

atualizar_head:
	move $s0, $t2
	
	# liberar mem�ria
	li $v0, 10
	syscall
	
	li $v0, 4
	la $a0, ProdutoExcluido
	syscall
	
	jr $ra

buscar_item:

atualizar_quantidade:

imprimir_produtos:
	
main:
	# Ler a op��o escolhida pelo usu�rio
	li $v0, 5
	syscall
	
	# Armazenar em $t0
	move $t0, $v0
	
	# Atribuicao de valores
	li $s1, 1
	li $s2, 2
	li $s3, 3
	li $s4, 4
	li $s5, 5
	li $s6, 6
	
	# Compar��es
	beq $t0, $s1, um
	beq $t0, $s2, dois
	beq $t0, $s3, tres
	beq $t0, $s4, quatro
	beq $t0, $s5, cinco
	beq $t0, $s6, seis
	
	# Sen�o estiver entre 1 e 6
	li $v0, 4
	la $a0, Erro
	syscall
	jal imprimir_menu
	
	um: 
		jal inserir_item
		j imprimir_menu
	dois:
		jal excluir_item
		j imprimir_menu
	tres:
		jal buscar_item
		j imprimir_menu
	quatro:
		jal atualizar_quantidade
		j imprimir_menu
	cinco:
		jal imprimir_produtos
		j imprimir_menu
	seis:
		# Fim do programa
		li $v0,10
		syscall

lista_vazia: ######## Por que quando a lista ta vazia faz isso !!!!!!!! ##########
	# novo n� se torna o head
	move $a0, $t3
	jr $ra

lista_excluir_vazia:
	li $v0, 4
	la $a0, ListaVazia
	syscall
	jr $ra