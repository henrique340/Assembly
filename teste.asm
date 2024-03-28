.data 
prompt: .asciiz "Digite a quantidade de termos da sequência de Fibonacci: "
comma: .asciiz ", "
newline: .asciiz "\n"

.text
main:
    # Imprimir prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Ler a quantidade de termos da sequência de Fibonacci
    li $v0, 5
    syscall
    move $t0, $v0  # Armazenar a quantidade de termos em $t0

    # Inicializar os primeiros dois termos da sequência
    li $t1, 0  # Primeiro termo
    li $t2, 1  # Segundo termo

    # Imprimir os primeiros dois termos (0 e 1)
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, comma
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimir os termos adicionais da sequência
    addi $t0, $t0, -2  # Decrementar a quantidade de termos em 2 (já imprimimos os dois primeiros)
    beq $t0, $zero, end_program  # Se não houver mais termos, encerrar o programa

fibonacci_loop:
    # Calcular o próximo termo da sequência de Fibonacci
    add $t3, $t1, $t2  # $t3 = $t1 + $t2
    move $t1, $t2      # $t1 = $t2
    move $t2, $t3      # $t2 = $t3

    # Imprimir o termo atual
    li $v0, 4
    la $a0, comma
    syscall

    li $v0, 1
    move $a0, $t3
    syscall

    # Decrementar o contador de termos
    addi $t0, $t0, -1

    # Verificar se ainda há termos a serem impressos
    bnez $t0, fibonacci_loop

end_program:
    # Imprimir nova linha e encerrar o programa
    li $v0, 4
    la $a0, newline
    syscall

    li $v0, 10
    syscall
