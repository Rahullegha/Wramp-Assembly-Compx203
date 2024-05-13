.global main
.text
main:
    sw $ra, 0($sp)
    subui $sp, $sp, 1
    
loop:
    jal serial_job          
    jal parallel_job       
    j loop


exit:
    addui $sp, $sp, 1
    lw $ra, 0($sp)

return:
    jr $ra

serial_job:
sjob:
lw $1, 0x70003($0) #load the value of serial status resistor in $1
andi $1, $1,0x1 #check the value of transmit data value is one or not
beqz $1, return #if transmit data sent is zero, jump return
lw $3, 0x70001($0) #get value from serial
slti $4, $3,'a' # check the value is less than character 'a'
sgti $5, $3,'z' # check the value is greater than character 'z'
or $6, $4, $5 # one of them is true
bnez $6,star # jump to star
sw $3, 0x70000($0) # send value to serial
j sjob #jump to serial job
star:
addi $2,$0,'*'
sw $2, 0x70000($0) #send value to serial 
j sjob # jump to serial job

parallel_job:
pjob:
lw $2, 0x73001($0) #load the value from push button resistor to $2
andi $1, $2,0x1 
bnez $1, push1 # if value is 1 jump to push1
andi $1, $2,0x2 
bnez $1, push2 # if value is 2 jump to push2
andi $1, $2,0x4
bnez $1, exit
j return
push1:
lw $2, 0x73000($0) # load value of switch 
remi $1, $2,4 # check multiple of 4
beqz $1, led_on # if have jump to led_on
j led_off # if not jump led_off
push2:
lw $2, 0x73000($0) # load value of switch 
xori $2, $2,0xffff # flip the value
remi $1, $2, 4 #check multiple of 4
bnez $1, led_off #if not jump led_off
led_on:
addi $1, $0,0xffff 
sw $1, 0x7300A($0) # send value to led resistor
j end #jump to end
led_off:
sw $0, 0x7300A($0) # off the led
end:
sw $2, 0x73009($0) # send value to parallel port led
srli $2, $2,4 #next number
sw $2, 0x73008($0) # send value to parallel port led
srli $2, $2,4 #next number
sw $2, 0x73007($0) # send value to parallel port led
srli $2, $2,4 #next number
sw $2, 0x73006($0) # send value to parallel port led
j pjob  
