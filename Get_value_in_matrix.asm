	.text
	.globl get_value_in_matrix

#Requires: $a0=Address of the matrix{1,...,side}; $a1=y; $a2=x{1,...,side}; $s3=side(>= 1)
#Returns: $$v0 The value of the matrix in (y,x)
get_value_in_matrix:

	
	move $t0, $a0 # The matrix
	move $t1, $a1 # Y
	move $t2, $a2 # X
	move $t3, $a3 # Side
	
	#(y-1)*side+x
	sub $t4, $t1, 1   # Y-1
	mul $t4, $t4, $t3 #(Y-1) * Side
	sub $t5, $t2, 1   #(X-1)
	add $t4, $t4, $t5 #(Y-1) * Side+x
	
	# Getthe address of A(y,x)
	mul $t4, $t4, 4  # Getting the offset in byte
	add $t4, $t4, $t0 # Getting the addres of the value
	
	# Load of the value in the return register
	lw $v0, 0($t4) # Load Ayx in $v0
		
	jr $ra # Return
