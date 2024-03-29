.global print
.text
print:
    #stack frame
    subui $sp, $sp, 5 
    #backup ra in stack
    sw $ra, 4($sp)  
    #backup the resistor
    sw $0, 0($sp)   
    sw $2, 1($sp)
    sw $3, 2($sp)
    sw $4, 3($sp)
    #initialize the resistors
    add $2, $0, $0  
    add $3, $0, $0
    add $4, $0, $0
    #get the value of switches and store in $4
    add $4, $4, $13
    #loop counter
    addi $2, $2,5
loop:
    #increment the stack pointer
    subui $sp, $sp,1
    #get the remainder of readswitches value and store in $3
    remi $3, $4,10
    #store value of 3 in stack
    sw $3, 0($sp)
    #divide the number by 10 to get next bit
    divi $4, $4,10
    #decrement the loop counter
    subi $2, $2,1 
    # jump back if loop counter not equal to zero
    bnez $2, loop
    #zero to the loop counter and resistor for further use
    add $2, $0, $0
    add $13, $0, $0
    #loop counter for next loop
    addi $4, $0, 5
leading_zero:
    #get the value from stack 
    lw $13, 0($sp)
    # jump to printnum if value is not zero
    bnez $13, printnum
    #decrement the loop counter
    subi $4, $4,1
    #add space if value is zero 
    addi $13, $13,32
    #store back modified value in stack again
    sw $13, 0($sp)
    #call the subroutine to print on serial
    jal putc
    #decrement the stack
    addui $sp, $sp,1 
    #check the value of loop counter for print last zero
    seqi $2, $4,1
    # jump to printnum if 2 is not zero
    bnez $2, printnum
    #jump back to loop
    j leading_zero
printnum:
    # get the value of stack
    lw $13, 0($sp)
    #convert the value to ascii
    addi $13, $13,48
    #store back to stack
    sw $13, 0($sp)
    #call subroutines for print
    jal putc
    #decrement stack
    addui $sp, $sp,1 
    # decrement the loop counter 
    subi $4, $4,1 
    # jump back if 4 is not zero
    bnez $4, printnum 	
end:
    #restore the resistor value back to resistor
    lw $0, 0($sp)
    lw $2, 1($sp)
    lw $3, 2($sp)
    lw $4, 3($sp)
    lw $ra, 4($sp)
    #remove the stack
    addui $sp, $sp, 5
    syscall 
    jr $ra
    