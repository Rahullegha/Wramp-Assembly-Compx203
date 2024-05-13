.global main
.text
main:
addi $2, $0,'*' # character store
checkready:
lw $1, 0x70003($0) #load the value of serial status resistor in $1
andi $1, $1,0x1 #check the value of transmit data value is one or not
beqz $1, checkready # if transmit data sent is zero, jump checkready
lw $3, 0x70001($0) #get value from serial
slti $4, $3,'a' # check the value is less than character 'a'
sgti $5, $3,'z' # check the value is greater than character 'z'
or $6, $4, $5 # one of them is true
bnez $6,star # jump to star
sw $3, 0x70000($0) # send value to serial
j checkready #jump to checkready
star:
sw $2, 0x70000($0) #send value to serial 
j checkready # jump to checkready
