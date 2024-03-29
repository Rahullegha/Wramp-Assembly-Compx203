#create global main label
.global main
#create text label for make executable
.text
# main label
main:
# jump to readswitches label and return 
jal readswitches
#add 8 value to resistor 3 
addi $3, $0, 8 
# initialize resistor 5 by making zero
add $5, $0, $0  


#make the loop label for add single bit 
loop:
# use the and operator for find the single bit. true or false
andi $4, $1, 1
# add the resistor 4 value to 5 
add $5, $5, $4
#right shift the value by one so we can read another bit 
srli $1, $1, 1 
# minus 1 from 3 for use as counter of loop 
subi $3, $3, 1
#loop if 3 is not zero 
bnez $3, loop  

#add the 5 value to 2 for screen 
add $2, $0, $5
#show the number on screen by calling writessd 
jal writessd
# jump back to main for infinite loop 
j main