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
# initialize resistor 7 by making zero
add $5, $0, $0  
# initialize resistor 7 by making zero
add $7, $0, $0 

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

# check whether value of 5 resistor is equal to 1
seqi $6, $5, 1
# if value of 6 is zero so we jump to else1 label 
beqz $6, else1
# if yes we use code for 1 and add to resistor 7
addi $7, $0, 0x70
# jumb to elseif label
j elseif

else1:
#check whether value of 5 resistor is equal to 2
seqi $6, $5, 2
# if value of 6 is zero so we jump to else2 label 
beqz $6, else2
# if yes we use code for 2 and add to resistor 7
addi $7, $0, 0x6B
# jumb to elseif label
j elseif

else2:
#check whether value of 5 resistor is equal to 3
seqi $6, $5, 3
# if value of 6 is zero so we jump to else3 label
beqz $6, else3
# if yes we use code for 3 and add to resistor 7
addi $7, $0, 0x0D
# jumb to elseif label
j elseif

else3:
#check whether value of 5 resistor is equal to 4
seqi $6, $5, 4
# if value of 6 is zero so we jump to else4 label
beqz $6, else4
# if yes we use code for 4 and add to resistor 7
addi $7, $0, 0x49
# jumb to elseif label
j elseif

else4:
#check whether value of 5 resistor is equal to 5
seqi $6, $5, 5
# if value of 6 is zero so we jump to else5 label
beqz $6, else5
# if yes we use code for 5 and add to resistor 7
addi $7, $0, 0x42
# jumb to elseif label
j elseif

else5:
#check whether value of 5 resistor is equal to 6
seqi $6, $5, 6
# if value of 6 is zero so we jump to else6 label
beqz $6, else6
# if yes we use code for 6 and add to resistor 7
addi $7, $0, 0x7F
# jumb to elseif label
j elseif

else6:
#check whether value of 5 resistor is equal to 7
seqi $6, $5, 7
# if value of 6 is zero so we jump to else7 label
beqz $6, else7
# if yes we use code for 7 and add to resistor 7
addi $7, $0, 0xB8
# jumb to elseif label
j elseif

else7:
#check whether value of 5 resistor is equal to 8
seqi $6, $5, 8
# if value of 6 is zero so we jump to else8 label
beqz $6, else8
# if yes we use code for 8 and add to resistor 7
addi $7, $0, 0x51
# jumb to elseif label
j elseif

else8:
#check whether value of 5 resistor is equal to 0
seq $6, $5, $0
# if value of 6 is zero so we jump to else8 label
beqz $6, else8
# if yes we use code for 0 and add to resistor 7
addi $7, $0, 0xA3
# jumb to elseif label
j elseif

elseif:
# add the value 7 into 2 for screen reference
add $2, $0, $7
#show the number on screen by calling writessd 
jal writessd
# jump back to main for infinite loop
j main