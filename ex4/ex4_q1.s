.data
counter: .word 0
old_vector: .word 0
.global main
.text


main:
add $2, $0, $0 
addi $2, $2,0x00AF  # Enable IRQ1, IRQ3 and IE
movgs $cctrl, $2   # Copy the value of $cctrl from $2
addi $4, $0, 3     # Enable Parallel Control Registor
sw $4, 0x73004($0)
movsg $3, $evec    # Get the old handler's address
sw $3, old_vector($0)   
la $4, handler    # Get the address of our handler
movgs $evec, $4  # And copy it in the exception vector($evec) register 


# Main program loop (Mainline code)
loop:
lw $4, counter($0)
remi $5, $4,10
sw $5, 0x73009($0)  # print to SSD
divi $4, $4,10
remi $5, $4,10 
sw $5, 0x73008($0)
j loop

handler:
movsg $13, $estat    # Get the value of Exception Status Register
andi $13, $13,0xffd0   # Check if there are interrupts other than IRQ1
beqz $13,interrupt_button  # If it is the one we want, Jump to interrupt_button
andi $13, $13,0xff70     #Check if there are interrupts other than IRQ3
beqz $13, parralel_interrupt  # If it is the one we want, Jump to parraled_interrupt
lw $13, old_vector($0)   # Otherwise, jump to the system handler(default) that we saved earlier.
jr $13

interrupt_button:
sw $0, 0x7f000($0)
lw $13, counter($0)    # Load, increase, Store the counter
addi $13, $13, 1
sw $13, counter($0)
rfe       # Return from the interrupt (rfe)

parralel_interrupt:
sw $0, 0x73005($0) # Acknowledge the interrupt
lw $13, 0x73001($0)
beqz $13, return
lw $13, counter($0)     # Load, increase, Store the counter
addi $13, $13, 1
sw $13, counter($0)

return:
rfe       # Return from the interrupt (rfe)



