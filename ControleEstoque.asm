.data 
	Menu: .asciiz "\n[1] Inserir um novo item no estoque\n[2] Excluir um item do estoque\n[3] Buscar um item pelo código\n[4] Atualizar quantidade em estoque\n[5] Imprimir os produtos em estoque\n[6] Sair\nOpcao:"
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
	# Input do código
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

	# Criar um novo nó
	li $v0, 9  # Alocando memória no Heap
	li $a0, 12  # 4 bytes para o código, 4 para a quantidade, 4 para o next
	syscall
	move $t3, $v0  # Armazenando o endereço do novo nó
	
	# Armazenar o código no endereço do nó
	sw $t1, 0($t3)
	
	# Armazenar a quantidade no endereço do nó
	sw $t2, 4($t3)
	
	# Se lista_vazia (head == null), novo nó vira o head
	beq $s0, $zero, lista_vazia
	move $t4, $s0                  # $t4 recebe o endereço no head
	loop:
		lw $t1, 8($t4)         # Carrega o next do nó atual
		beqz $t1, saida_loop   # Se (next == null) fim do loop
		move $t4, $t1          # Próximo nó
		j loop
	saida_loop:	
	# Conectando o novo nó ao final da lista
	sw $t3, 8($t4)
	jr $ra

excluir_item:
	# Se a lista está vazia
	beq $s0, $zero, lista_excluir_vazia

	# Solicitação do código pelo usuário
	li $v0, 4
	la $a0, ExcluirProduto
	syscall
	li $v0, 5
	syscall
	move $t1, $v0
	
	# inicializando os registradores
	move $t2, $s0    # $t2 recebe o endereço do nó atual
	move $t3, $zero  # $t3 recebe o endereço do nó anterior

loop_excluir:
	beqz $t2, lista_excluir_vazia  # Sai do loop quando chegar ao final da lista
	
	# Carregando o código
	lw $t4, 0($t2)
	
	# Se o código for igual ao input
	beq $t4, $t1, encontrado
	
	# atualizar endereços
	move $t3, $t2          # $t3 = $t2
	lw $t2, 4($t2)         # $t2 avança para o próximo nó
	j loop_excluir

encontrado:
	# Se o nó a ser excluído é o head
	beq $t3, $zero, atualizar_head
	
	# Se o nó a ser excluido não é o head
	sw $t2, 8($t3)         # Apontar o next nó anterior para o next do nó atual

atualizar_head:
	move $s0, $t2
	
	# liberar memória
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
	# Ler a opção escolhida pelo usuário
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
	
	# Comparções
	beq $t0, $s1, um
	beq $t0, $s2, dois
	beq $t0, $s3, tres
	beq $t0, $s4, quatro
	beq $t0, $s5, cinco
	beq $t0, $s6, seis
	
	# Senão estiver entre 1 e 6
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
	# novo nó se torna o head
	move $a0, $t3
	jr $ra

lista_excluir_vazia:
	li $v0, 4
	la $a0, ListaVazia
	syscall
	jr $ra