.data
#Nome: Andre Moreira Guimaraes       RA: 10416590
#Nome: Henrique Yuji Isogai Yoneoka  RA: 10418153 

array: .space 5 
       .align 2
       
numero: .word 10 

menu: .asciiz "Digite um numero decimal: "

.text

li $v0, 4 #imprimir menu
la $a0, menu
syscall

li $v0, 5#ler numero decimal
syscall
move $t0, $v0
li $t1, 0

binario:#funcao para transformar em binario

blt $t0, 2, sair

div $t0, $t0, 2
mfhi $t3
mflo $t4

sw $t3, array($t1)
addi $t1, $t1 4

j binario

sair:

sw $t4, array($t1)
	loop:
	blt $t1, 0, finalizar
	
	lw $a0, array($t1)
	li $v0, 1
	syscall
	
	subi $t1, $t1, 4
	
	j loop
	
finalizar:

li $v0, 10#finalizar programa
syscall
