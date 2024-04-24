	.data

size_input: .asciiz "Input the lenght of the side of the matrix: "
value_input: .asciiz "Input the next value: "
end_message: .asciiz "Input complited!!\n"

	.text

	.globl matrix_input
	
# RETURNS: $v0 addres of new matrix; $v1 side of new matrix
matrix_input:

	la $a0, size_input # The size message
	li $v0, 4   	   # The code to print a string
	syscall 	   # A syscall
	
	li $v0, 5	   # The code to read an int(side of matrix)
	syscall		   #A syscall
	
	move $t0, $v0      # Saving side of matrix
	
	mul $t1, $t0, $t0  # Getting the number of element of the matrix
	
	mul $a0, $t1, 4   # Getting the number of byte of the matrix 
	li $v0, 9         # The code to allocate a number of byte
	syscall		  # A syscall
	
	move $t2, $v0     # Iterator for the cicle(addres)
	move $t3, $v0     # Addres of the matrix to return
	
	li $t4, 0 	  # Iterator for the cicle(number of element)
	
	do:
		la $a0, size_input # The element message
		li $v0, 4   	   # The code to print a string
		syscall 	   # A syscall
		
		li $v0, 5	   # The code to read an int(element of matrix)
		syscall		   # A syscall
		
		sw $v0, 0($t2)     # Store the value read in the actual space of the matrix
		addi $t4, $t4, 1   # Add one to the element of the matrix inputed
		addi $t2, $t2, 4   # Add for to the position in the data section
	
	blt $t4, $t1, do # If the iterator is less then the number of element keep adding element
	
	la $a0, end_message# The input end message
	li $v0, 4   	   # The code to print a string
	syscall 	   # A syscall
	
	move $v0, $t3 # Address of the matrix
	move $v1, $t0 # Side of the matrix
	
	jr $ra 	      # Return
	