	.text
	
	.globl generate_determinant
	
# REQUIRES: $a0=the address of a square matrix; $a1=The lenght of the side
# RETURNS: $v0= The determinant
generate_determinant:
	
	sub $sp $sp 20 #INIZIO PROCEDURA
	# Salvo i contenuti di $s0,...,$s2
	sw $ra 16($sp)
	sw $s0 12($sp)
	sw $s1 8($sp)
	sw $s2 4($sp)
	sw $s3 0($sp)

	move $s0, $a0 # Matrix addres
	move $s1, $a1 # Matrix side
	
	beq $s1, 1 determinant_1 # If the matrix is 1*1 go to first case
	beq $s1, 2 determinant_2 # If the matrix is 2*2 go to second case
	j determinant_else       # In every other case skip to the general case
	
	determinant_1: # Case with a side of 1
		move $a0, $s0 # Address of hte matrix
		li $a1, 1     # y
		li $a2, 1     # x
		move $a3, $s1 # side
		
		jal get_value_in_matrix
		
		j end
	
	determinant_2: # Case with a side of 2
		
		# Getting a11
		move $a0, $s0 # Address of the matrix
		li $a1, 1     # y
		li $a2, 1     # x
		move $a3, $s1 # Side
		
		jal get_value_in_matrix
		
		move $s2, $v0 # A11
	
		# Getting a22
		move $a0, $s0 # Address of the matrix
		li $a1, 2     # y
		li $a2, 2     # x
		move $a3, $s1 # Side
		
		jal get_value_in_matrix 
		
		mul $s2, $s2, $v0 # A11*A22
	
		# Getting a21	
		move $a0, $s0 # Address of the matrix
		li $a1, 2     # y
		li $a2, 1     # x
		move $a3, $s1 # Side
		
		jal get_value_in_matrix
		
		move $s3, $v0 # A21
	
		# Getting a12
		move $a0, $s0 # Address of the matrix
		li $a1, 1     # y
		li $a2, 2     # x
		move $a3, $s1 # Side
		
		jal get_value_in_matrix 
		
		mul $s3, $s3, $v0 # A21*A22
		
		sub $v0, $s2, $s3 # A11*A22-A21*A22
	
		j end

	determinant_else:
		move $a0, $s0 # Matrix addres
		move $a1, $s1 # Matrix side
		
		jal generate_bigger_determinat
		
		j end
		# Da implementare a parte
	
end:

	# ripristino contenuti di $s0,...,$s2
	lw $ra 16($sp)
	lw $s0 12($sp)
	lw $s1 8($sp)
	lw $s2 4($sp)
	lw $s3 0($sp)
	add $sp $sp 20

	jr $ra
