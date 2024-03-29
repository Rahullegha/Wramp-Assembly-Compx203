.text				#specifies that what follows are instructions
.global main			#specifies that the label "main" is globally accessible

main:				#entry point into the program
	sw $0, 0x73004($0)	#enable individual control of SSD segments
	
	addi $2, $0, 0		#initialise loop counter to zero
loop:
	seqi $8, $2, 13		#has the loop finished?
	bnez $8, main		#if so, go to "main"
		
	jal write		#write the pattern to the SSD
	jal delay		#delay so it can actually be seen
	
	addi $2, $2, 1		#increment loop counter
	j loop			#go around again

write:
    lw $1, 0x73007($0)  # transfer SSD contents to the left
    sw $1, 0x73006($0)
    lw $1, 0x73008($0)
    sw $1, 0x73007($0)
	lw $1, 0x73009($0)
	sw $1, 0x73008($0)
	lw $1, hello($2)	#load the new pattern to the rightmost SSD
	sw $1, 0x73009($0)	
	jr $ra			#return

delay:
	addui $9, $0, 0xFFFF 	#a big number to count down from
	slli $9, $9, 2		#make it even bigger
delayLoop:
	subui $9, $9, 1		#around we go...
	bnez $9, delayLoop
	jr $ra			#return

.data				#specifies that what follows are data with initial values
hello:				#SSD patterns to encode "HELLO C200"
	.word 0x76 #H
	.word 0x79 #E
	.word 0x38 #L
	.word 0x38 #L
	.word 0x3F #O
	.word 0x00 
	.word 0x39 #C
	.word 0x5B #2
	.word 0x3F #0
	.word 0x4F #3
	.word 0x00
	.word 0x00
	.word 0x00
