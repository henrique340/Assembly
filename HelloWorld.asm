.data 
	Msg: .asciiz "Hello World"

.text
	li $v0,4
	la $a0,Msg
	syscall