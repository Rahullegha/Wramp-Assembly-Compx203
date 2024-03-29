#create global main label
.global main
#create text label for make executable
.text
# main label
main:
# jump to readswitches label and return 
jal readswitches
#add the value of readswitches from 1 to 2 resistor 
add $2, $1, $0
# show the number on screen by calling writessd 
jal writessd
# jump back to main for infinite loop 
j main