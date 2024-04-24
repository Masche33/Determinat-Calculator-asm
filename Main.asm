	.data

	.text
	.globl main

main:

	jal matrix_input

	move $a0, $v0
	move $a1, $v1
	
	jal generate_determinant
		
	move $a0, $v0
	li $v0, 1
	syscall
	
	
	li $v0, 10
	syscall
