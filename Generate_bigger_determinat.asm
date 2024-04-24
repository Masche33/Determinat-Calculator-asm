 	.text
	.globl generate_bigger_determinat
	
generate_bigger_determinat:
	
	sub $sp $sp 24 #INIZIO PROCEDURA BIGGER
	# Salvo i contenuti di $s0,...,$s2
	sw $ra 20($sp)
	sw $s0 16($sp)
	sw $s1 12($sp)
	sw $s2 8($sp)
	sw $s3 4($sp)
	sw $s4 0($sp)
	
	move $s0, $a0 # Matrix address
	move $s1, $a1 # Matrix side
	move $s2, $a1 # Iterator
	li $s4, 0
	
	do:
	
		# Getting a11
		move $a0, $s0 # Matrix address
		li $a1, 1     # Y 
		move $a2, $s2 # X iterated
		move $a3, $s1 # Side
		
		jal get_value_in_matrix
		
		move $s3, $v0 # Saving a11, in $s3
		
		li $a0, 1     # Y to evaluate
		move $a1, $s2 # X to evaluate
		
		jal is_position_odd
		
		mul $s3, $s3, $v0 # ayx*(-1)^(y+x)
		
		
		move $a0, $s0 # Matrix address
		move $a1, $s1 # Matrix side
		move $a2, $s2 # Column to eliminate x
		li $a3, 1     # Row to eliminate    y
		
		jal generate_sub_matrix
		
		move $a0, $v0 # Address of the new matrix
		move $a1, $v1 # Side lenght of the new matrix
		
		jal generate_determinant
		
		mul $s3, $s3, $v0  # ayx*(-1)^(y+x)*det sub matrix
		
		add $s4, $s4, $s3  # Add the determinant the sum
			
		sub $s2, $s2, 1    #Increment by one x
	bne $s2, 0, do # Cicle to iterate the first row
	
	end:


	# ripristino contenuti di $s0,...,$s2
	move $v0, $s4
	lw $ra 20($sp)
	lw $s0 16($sp)
	lw $s1 12($sp)
	lw $s2 8($sp)
	lw $s3 4($sp)
	lw $s4 0($sp)
	add $sp $sp 24

	jr $ra # Return


# REQUIRES: $a0=y; $a1=x
# RETURNS: 1 if y+x is even; -1 if y+x is odd
is_position_odd:
	
	
	move $t0, $a0 # Y
	move $t1, $a1 # X
	
	li $v0, 1  # Set the return value to 1 as default and changing only if corrected
	
	add $t0, $t0, $t1 # In $t0 sum Y+X
	div $t0,$t0,  2   # Divide by 2
	mfhi $t0          # 1 if odd, 0 if even
	
	
	beqz $t0, return # If zero return
	li $v0, -1       # else set return value to -1
	
	return:	
	jr $ra # return
