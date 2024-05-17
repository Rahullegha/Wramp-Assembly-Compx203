.data
counter: .word 0
old_vector: .word 0
carriage: .word '\r'
newline: .word '\n'
dot: .word '.'
.global main
.text


main:
sw $ra, 0($sp)
subui $sp, $sp, 1

add $2, $0, $0 
addi $2, $2,0x00EF  # Enable IRQ1, IRQ2, IRQ3 and IE
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
divi $4, $4,100 
remi $5, $4,10
sw $5, 0x73009($0) # print to ssd
divi $4, $4,10
remi $5, $4,10 
sw $5, 0x73008($0) #print to ssd
j loop

handler:
movsg $13, $estat   # Get the value of Exception Status Register
andi $13, $13, 0xffb0 # Check if there are interrupts other than IRQ2
beqz $13, timer  # If it is the one we want, Jump to timer
andi $13, $13,0xff70     #Check if there are interrupts other than IRQ3
beqz $13, parralel_interrupt  # If it is the one we want, Jump to parraled_interrupt
lw $13, old_vector($0)   # Otherwise, jump to the system handler(default) that we saved earlier.
jr $13

timer:
sw $0, 0x72003($0)  # Acknowledge the timer interrupt
addi $13, $0, 24 # Set timer send 100 interrupt per second 
sw $13, 0x72001($0) 
addi $13, $0, 0x3   # Enable Programmer timer and Auto Restart
sw $13, 0x72000($0)
lw $13, counter($0)  # Load, increase, Store the counter
addi $13, $13, 1
sw $13, counter($0)
rfe    # Return from the interrupt (rfe)

parralel_interrupt:
sw $0, 0x73005($0) # Acknowledge the interrupt
lw $13, 0x73001($0) # 
seqi $13, $13, 0x4  #If push button is equal to button 2 value 
bnez $13, button2   #then, jump to button2
lw $13, 0x73001($0) #If push button is equal to button 2 value 
seqi $13, $13, 0x2  #If push button is equal to button 1 value 
bnez $13, button1  #then, jump to button2
lw $13, 0x73001($0)
beqz $13, return  # if value is zero then jump to return
lw $13, 0x72000($0)
xori $13, $13,0x3 # flip the bit if timer is on then it off and off then on
sw $13, 0x72000($0)
rfe # Return from the interrupt (rfe)

button1:
lw $13, 0x72000($0)
seqi $13, $13,0x3  # if the timer is on
bnez $13, serial_port # jump to serial
sw $0, 0x72000($0)  # otherwise, zero the value of counter and off the timer
sw $0, counter($0)
rfe # Return from the interrupt (rfe)

serial_port:
jal check
lw $13, carriage($0)  # \r
sw $13, 0x71000($0)

jal check
lw $13, newline($0)  # \n
sw $13, 0x71000($0)

jal check
lw $13, counter($0)  # num_1
divi $13, $13,1000 
remi $13, $13,10 
addi $13, $13,'0' 
sw $13, 0x71000($0)

jal check
lw $13, counter($0)  # num_2
divi $13, $13,100 
remi $13, $13,10 
addi $13, $13,'0' 
sw $13, 0x71000($0)

jal check
lw $13, dot($0)  # .
sw $13, 0x71000($0)

jal check
lw $13, counter($0) #num_3
divi $13, $13,10 
remi $13, $13,10 
addi $13, $13,'0' 
sw $13, 0x71000($0)

jal check
lw $13, counter($0)  #num_4
remi $13, $13,10 
addi $13, $13,'0' 
sw $13, 0x71000($0)
rfe 

check:
lw $13, 0x71003($0)
andi $13, $13,0x2
beqz $13, check
jr $ra

button2: # Exit the Program
sw $0, 0x72000($0)  # reset the timer
sw $0, counter($0)  # reset the counter         
sw $0, 0x73009($0)  # reset the SSD       
sw $0, 0x73008($0)  # reset the SSD    
addui $sp, $sp, 1
lw $ra, 0($sp)
jr $ra

return:    # Return from the interrupt (rfe)
rfe 
