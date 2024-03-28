.data 
#Nome: André Moreira Guimarães      RA: 10416590
#Nome: Henrique Yuji Isogai Yoneoka   RA: 10418153

menu: .asciiz "Olá Digite o número que deseja ser fatorado: "
resultado: .asciiz "O fatorial do seu número digitado é: "

.text
main:

li $v0, 4 #imprimir menu
la $a0, menu
syscall

li $v0, 5 #ler numero inteiro
syscall
move $t0, $v0

#li $t1, 1 #t1 vale 1 t4 vale 1
li $t4, 1 

fatorial:

beq $t0,  $zero, fim 
mul $t4, $t4, $t0 #fatorar
addi $t0, $t0, -1
j fatorial

fim:
li $v0, 4 #imprimindo a string resultado
la $a0, resultado
syscall

li $v0, 1 #imprimindo o resultado numerico
move $a0, $t4
syscall

li $v0, 10 #encerrar o programa
syscall
