	.text
	.globl generate_sub_matrix
	
# REQUIRES: $a0 the address of a matrxi; $a1 the side of the matrix; $a2 The column to eliminate x; $a3 the row to eliminate y
# RETURNS: The address of the sub matrix in $v0
generate_sub_matrix:

	sub $sp $sp 36 #INIZIO PROCEDURA: GENERATE SUB MATRIX
	# Salvo i contenuti di $s0,...,$s2
	sw $ra 32($sp)
	sw $s0 28($sp)
	sw $s1 24($sp)
	sw $s2 20($sp)
	sw $s3 16($sp)
	sw $s4 12($sp)
	sw $s5 8($sp)
	sw $s6 4($sp)
	sw $s7 0($sp)
	
	move $s0, $a0 # Address of the matrix
	move $s1, $a1 # Side
	move $s2, $a2 # X
	move $s3, $a3 # Y
	
	
	sub $s4, $s1, 1   # New side
	mul $s4, $s4, $s4 # Lenght of the new matrix
	mul $s4, $s4, 4   # Get the number of byte
	
	move $a0, $s4     # Dinamic creation of the array
	li $v0, 9
	syscall		  # Actual creation

	move $s4, $v0  # Getting the address of the array of the new size
	
	move $s5, $s4  # Element ounter
	li $s6, 1      # X counter
	li $s7, 1      # Y counter
	
	
	do_y: # Do while y
		do_x: # Do while x
			beq $s6, $s2, skip # If the x counter is equal to the x to eliminate then skip
			beq $s7, $s3, skip # If the y counter is equal to the y to eliminate then skip
			
			move $a0, $s0 # Matrix to trim address
			move $a1, $s7 # Column to eliminate
			move $a2, $s6 # Row to eliminate
			move $a3, $s1 # Side of the starting matrix
			
			jal get_value_in_matrix # Getting the value ayx of the matric
			
			sw $v0, 0($s5) # Storing the value found in the matrix
			addi $s5, $s5, 4 # Adding the offset to the counter
			
			
		skip:
			addi $s6, $s6, 1 # Adding 1 to the x counter
		ble $s6, $s1, do_x # Checking if the x is out of bound
		addi $s7, $s7, 1  # Adding one to the y counter
		li $s6, 1         #Resetting the x column
	ble $s7, $s1, do_y  # Checking if the y is out of bound
		
end:
	move $v0, $s4   # The addres of the new matrix
	sub $v1, $s1, 1 #Side of the new matrix
	
	lw $ra 32($sp)
	lw $s0 28($sp)
	lw $s1 24($sp)
	lw $s2 20($sp)
	lw $s3 16($sp)
	lw $s4 12($sp)
	lw $s5 8($sp)
	lw $s6 4($sp)
	lw $s7 0($sp)
	add $sp $sp 36

	jr $ra #return
		
