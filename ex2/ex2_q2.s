.global main
.text
# main subroutine
main:
#add stack frame
subui $sp, $sp,4
#backup resistor
sw $2, 3($sp)
#backup the ra resistor
sw $ra, 4($sp)
# call the readswitches to get value
jal readswitches
# add the value of 1 in the 2
add $2, $1, $0
split:
#shift the number right by 8 to get the left 8 bits
srli $2, $2,8
# and operator with 8 bits on 1 to get right most 8 bits
andi $1, $1,0xFF
#store the value in stack to use in count subroutine
sw $1, 0($sp)
sw $2, 1($sp)
jal count
#pop
lw $2, 3($sp)
lw $ra, 4($sp)
addui $sp, $sp,4 
syscall 
jr $ra
