.global main
.text
# main subroutine
main:
addi $2, $0, 'a' # store 'a' character 
addi $3, $0, 'A' # store 'A' character
lowercase:
lw $1, 0x71003($0) #load the value of serial status resistor in $1
andi $1, $1,0x2  #check the value of transmit data value is one or not
beqz $1,lowercase # if transmit data sent is zero, jump lowercase
sw $2, 0x71000($0) #send to the serial 2
seqi $4, $2,'z'  # check the value is equal to 'z'
addi $2, $2,1 # next charater
beqz $4, lowercase # jump to lowercase is charater is less than 'z'
uppercase:
lw $1, 0x71003($0) #load the value of serial status resistor in $1
andi $1, $1,0x2 #check the value of transmit data value is one or not
beqz $1,uppercase # if transmit data sent is zero, jump lowercase
sw $3, 0x71000($0) #send to the serial 2
seqi $5, $3,'Z' # check the value is equal to 'Z' 
addi $3, $3,1 # next charater
beqz $5, uppercase # jump to lowercase is charater is less than 'Z'
endloop:
jr $ra  

