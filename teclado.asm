.data 
	input: .space 81
	inputsize: .word 80
	prompt: .asciiz "Digite uma string: "
	output: .asciiz "Você digitou: "
	

 .text 
 	li $v0,4
 	la $a0,prompt
 	syscall
 	
 	 li $v0,8
 	 la $a0, input
 	 lw $a1, inputsize
 	 syscall 
 	 
 	 li $v0,4
 	 la $a0,output
 	 syscall
 	 
 	 la $a0, input
 	 syscall