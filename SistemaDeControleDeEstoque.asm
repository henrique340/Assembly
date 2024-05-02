.data
# Cabecalho
Cabecalho: .asciiz "\n================================\nSistema de Controle de Estoque\n===============================\n"

# Menu
menuOpcoes: .asciiz "\n[1] Inserir um novo item no estoque\n[2] Excluir um item do estoque\n[3] Buscar um item pelo código\n[4] Atualizar quantidade em estoque\n[5] Imprimir os produtos em estoque\n[6] Sair\nOpcao: "
menuErro: .asciiz "\nEscolha uma opcao valida! \n"

# Excluir
excluidoSucesso: .asciiz "\nProduto excluido com sucesso!\n"
excluirListaVazia: .asciiz "\nA lista esta vazia! \n"

# Buscar
buscarEncontrado: .asciiz "\nProduto encontrado! Unidades disposiveis: "

# Atualizar
atualizarFim: .asciiz "\nA lista esta vazia\n"

# Imprimir
imprimirMensagemCodigo: .asciiz "Codigo: "
imprimirMensagemQuantidade: .asciiz "Quantidade: "
imprimirLinha: .asciiz "\n"
imprimirVazia: .asciiz "\nA lista esta vazia!\n"

# No
head: .word 0

# Geral
codigoProduto: .asciiz "Digite o codigo do produto: "
quantidadeProduto: .asciiz "Digite a quantidade do produto: "
naoEncontrado: .asciiz "\nProduto nao encontrado!\n"

.text
menu:
	# Imprime o cabeçalho
	li $v0, 4
	la $a0, Cabecalho
	syscall
	
	# Imprime o menu de opcoes
    	li $v0, 4
    	la $a0, menuOpcoes
    	syscall
    	li $v0, 5
    	syscall
	move $t0, $v0		#$t0 = input opcao

	# Comparacoes
	beq $t0, 1, um
	beq $t0, 2, dois
	beq $t0, 3, tres
	beq $t0, 4, quatro
	beq $t0, 5, cinco
	beq $t0, 6, seis
	
	# Se não estiver entre 1 e 6
	li $v0, 4
	la $a0, menuErro
	syscall
	j menu

	um:	jal inserir
		j menu
		
	dois:	jal excluir
		j menu
		
	tres:	jal buscar
		j menu
		
	quatro:	jal atualizar
		j menu
		
	cinco:	jal imprimir
		j menu
		
	seis:	jal encerrar
	
#----------------------------------------#
#		Inserir item		 #
#----------------------------------------#

inserir:
	# Input do código 
	li $v0, 4
	la $a0, codigoProduto
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
        
        # Input da quantidade 
	li $v0, 4
	la $a0, quantidadeProduto
	syscall
	li $v0, 5
	syscall
	move $t3, $v0
	
	# Criando uma lista encadeada
        li $a0, 12			# Define o tamanho do no
        li $v0, 9			# aloca a memoria dinamicamente 
        syscall
        move $t1, $v0			# $t1 = endereco do novo no
	
	# Armazenando as variaveis
        sw $t2, ($t1)			# $t2 = codigo do produto
        sw $t3, 4($t1)			# $t3 = quantidade do produto
        sw $0, 8($t1)			# Inicializa o próximo nó atual como null
        
        # Verificar se a lista esta vazia
        lw $t4, head			# $t4 = para percorrer a lista
        beqz $t4, inserir_lista_vazia	
        
        # Se a lista não está vazia
       	inserir_loop:
        	lw $t5, 8($t4)		# $t5 = endereco do proximo no
        	beqz $t5, inserir_novo_no
        	move $t4, $t5
        	j inserir_loop
        
        # Adiciona um novo no no final da lista encadeada
        inserir_novo_no:
        	sw $t1, 8($t4)		 
        	jr $ra
        
        # Tratamento quando a lista esta vazia
        inserir_lista_vazia:
        	sw $t1, head		# head aponta para o novo no
        	jr $ra			# Volta para o menu
	

#----------------------------------------#
#		Excluir item		 #
#----------------------------------------#

excluir:
	# Verifica se a lista está vazia
	lw $t1, head			# $t1 para percorrer a lista
	beqz $t1, excluir_lista_vazia	# Se head == null, está vazia
	
	# Input do usuario
	li $v0, 4
	la $a0, codigoProduto
	syscall
	li $v0, 5
	syscall
	move $t2, $v0			# $t2 = codigo
	move $t3, $t1			# $t3 = endereço do nó atual
	move $t4, $zero			# $t4 = endereço do nó anterior
	
	# loop para encontrar o produto a ser excluido
	excluir_loop:
		beqz $t3, excluir_nao_encontrado# Verifica se chegou ao final da lista
		lw $t5, ($t3)			# Codigo do nó atual
		beq $t5, $t2, excluir_encontrado
		move $t4, $t3			# Atualiza os registradores ($t4 é o nó atual)
		lw $t3, 8($t3)			# Avança para o próximo nó
		j excluir_loop
		
	excluir_encontrado:
		lw $t5, 4($t3)			# $t5 = quantidade do nó atual
		
		# se quantidade > 1
		bgt $t5, 1, excluir_subtrair	# Subtrai 1

		# Se não
		# Se é o head (excluir head)
		beqz $t4, excluir_atualizar_head 
		
		# Se não é o head		
		lw $t6, 12($t3)			# Carrega o proximo do no atual
		sw $t5, 12($t4)			# Atualiza o no atual para o proximo do no atual
		
		# Imprime que foi excluído
		li $v0, 4
		la $a0, excluidoSucesso
		syscall
		jr $ra				# Volta para o menu
	
	# Subtrai 1 da quantidade do produto
	excluir_subtrair:
		subi $t5, $t5, 1
		sw $t5, 4($t3)
		li $v0, 4
		la $a0, excluidoSucesso
		syscall
		jr $ra
	
	excluir_atualizar_head:
		lw $t6, 12($t3)			# Carrega o proximo do no atual
		sw $t6, head			# Atualiza a head para o proximo do no atual
		
		li $v0, 4
		la $a0, excluidoSucesso
		syscall
		
		jr $ra				# volta para o menu
	
	# Imprime que a lista esta vazia
	excluir_lista_vazia:
		li $v0, 4
		la $a0, excluirListaVazia
		syscall
		
		jr $ra				# Volta para o menu
		
	# Imprime uma mensagem que nao foi encontrado
	excluir_nao_encontrado:
		li $v0, 4
		la $a0, naoEncontrado
		syscall
		jr $ra				# Volta para o menu
	
#----------------------------------------#
#		Busca Item		 #
#----------------------------------------#

buscar:	
	lw $t1, head
	beqz $t1, buscar_nao_encontrado
	
	# Imprime e faz o input do codigo do produto
	li $v0, 4
	la $a0, codigoProduto
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	# loop para encontrar o produto
	buscar_loop:
		lw $t2, 0($t1)
		beq $t2, $t0, buscar_encontrado
		lw $t1, 8($t1)
		bnez $t1, buscar_loop
		
	# Imprime uma mensagem quando o produto nao e encontrado
	buscar_nao_encontrado:
		li $v0, 4
		la $a0, naoEncontrado
		syscall
		jr $ra	
		
	buscar_encontrado:
		li $v0, 4
		la $a0, buscarEncontrado
		syscall
		
		# Imprime a quantidade do produto
		lw $t3, 4($t1)
		li $v0, 1
		move $a0, $t3
		syscall
		jr $ra

#----------------------------------------#
#	   Atualizar quantidade  	 #
#----------------------------------------#

atualizar:
	# Verifica se a lista esta vazia
	lw $t1, head			# inicializa $t1
	beqz $t1, atualizar_fim		# Se estiver vazia
	
	# Se nao esta vazia
	# Imprime e faz o input do codigo do produto
	li $v0, 4
	la $a0, codigoProduto
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	
	# Imprime e faz o input da nova quantidade
	li $v0, 4
	la $a0, quantidadeProduto
	syscall
	li $v0, 5
	syscall
	move $t2, $v0
	
	
	atualizar_fim:
		li $v0, 4
		la $a0, atualizarFim
		syscall
		jr $ra
	
#----------------------------------------#
#	     Imprimir produtos    	 #
#----------------------------------------#

imprimir:
	# Mostrar estoque
	lw $t1, head
	beqz $t1, imprimir_fim_lista
	
	imprimir_loop:
		# Imprime o codigo do produto
		li $v0, 4
		la $a0, imprimirMensagemCodigo
		syscall
		lw $t2, 0($t1)
		li $v0, 1
		move $a0, $t2
		syscall
		
		# Imprimindo uma linha vazia
		li $v0, 4
		la $a0, imprimirLinha
		syscall
		
		# Imprime a quantidade do produto
		li $v0, 4
		la $a0, imprimirMensagemQuantidade
		syscall
		lw $t3, 4($t1)
		li $v0, 1
		move $a0, $t3
		syscall
		
		# Imprimindo duas linhas vazias
		li $v0, 4
		la $a0, imprimirLinha
		syscall
		li $v0, 4
		la $a0, imprimirLinha
		syscall
		
		# Proximo no
		lw $t1, 8($t1)
		bnez $t1, imprimir_loop
		jr $ra
	imprimir_fim_lista:
		li $v0, 4
		la $a0, imprimirVazia
		syscall
		jr $ra
		
#----------------------------------------#
#	         Encerrar       	 #
#----------------------------------------#

encerrar:
	li $v0, 10
	syscall
