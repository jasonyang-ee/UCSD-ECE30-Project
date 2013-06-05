######################
#                    #
# Project Submission #
#                    #
######################

# Partner1: (your name here), (Student ID here)
# Partner2: (your name here), (Student ID here)

# Linked list structure
# int data 4 bytes
# node next_address 4 bytes

	.data
printIntro:	.asciiz "The linked list contains:\n"
printSorted:	.asciiz "The sorted linked list contains:\n"
printNL:	.asciiz "\n"
printComma:	.asciiz ", "
arrLen:		.word 4 #500
randnums:	.word 3859,-4698,2684,3580

#,-107,4685,2850,-2449,-850,-1513,-2140,105,2233,-2255,-4245,2723,4385,-4781,1573,2270,3205,2186,-3573,-4601,-3505,2872,3146,4352,-3905,117,-3086,2223,323,-578,-1371,1228,-585,3545,848,-2233,672,1070,-551,2185,540,-2147,3327,-2468,-1561,4438,146,-4290,-3697,2505,-1186,3404,2836,2229,-3906,3931,-2162,4472,-2467,-301,-46,1628,4990,-2767,-4455,741,-2150,-291,-371,2066,-4070,-3566,-4225,3741,-1629,-4965,643,-2242,-3023,1547,-232,3631,988,-3355,-2687,3596,-1731,1559,3179,3211,-1577,-194,1671,-2274,3655,4451,1322,-3859,-3260,-1541,3965,-1357,-125,3344,-1702,1550,4705,2725,45,569,-1192,-4556,1392,-2905,3719,2989,3775,3113,3894,3698,-4001,3399,-4575,-412,1496,1488,-3,-2256,2242,-3827,-3535,-2522,2837,-3307,-2331,-2763,4856,3323,-4800,646,1505,4187,-4171,4142,693,4669,-3651,-811,-3186,-4490,3600,3045,-1797,-4572,-1617,3526,-1744,1903,4634,-2280,-582,1586,2787,-577,1382,3537,3886,1956,-620,-1354,2237,1787,4546,-3845,-2873,-1088,2101,4266,-2527,1995,3105,-2350,-2009,-4175,-1033,3710,-1355,-1208,-3800,-1142,-964,3603,-1383,-2622,-314,-4221,2203,553,-3585,3100,-1399,2588,678,-195,1262,-2534,-4298,-2759,-448,4708,414,4627,-1304,-4573,-4881,4181,-4279,2012,4711,2137,2329,2828,-1125,2214,-166,883,1649,4519,-3457,294,4509,2569,-4022,2888,-2342,2348,3657,2679,3581,3570,1919,4868,-4985,4343,1466,214,-849,1027,4047,-460,3345,855,31,375,2566,-3337,-1989,1146,708,-1239,-3117,-3220,-3083,3817,1964,4139,2201,-407,2692,-1464,-4887,-799,-355,3591,-3423,-67,-3839,1622,-4733,383,-1414,1740,-3761,4154,-1704,4398,1355,-4219,658,4790,-3878,-4422,-3606,3062,-2250,-4841,3799,-2976,602,761,-4849,819,1295,-2700,-3514,-3681,-4707,-131,-4738,4663,3801,849,-2896,-573,3883,4100,1709,-3075,-509,-1499,-4793,-4260,-1290,-36,4875,-2380,2002,1521,-2604,-4867,-2710,4857,-2835,2838,-498,4226,-239,3732,4169,928,3060,4344,4821,4439,-4033,4,-4528,1857,-4866,2834,-2407,-1537,-3042,-1062,3094,-4874,2287,2083,-4503,-116,1170,86,3216,4567,-745,-863,-3680,3670,-2206,-333,3348,4814,1017,357,-2792,1345,577,845,4444,3625,-2703,3840,498,-433,4683,4935,-1569,-3901,-1263,-2236,-4606,-4844,-4603,4516,3663,4297,-2744,-3746,-2926,-2367,-1039,2527,4102,3666,-1473,-4128,-2794,-2807,-8,2366,-1990,-2311,1940,2150,4499,-3286,-2287,1548,-3892,2084,2498,1873,1503,-3804,3171,2108,1088,-2292,3137,-3214,-2851,-4695,996,-2770,3731,1095,1714,1743,2668,2259,3662,-1416,810,4832,-127,-3842,4355,-3812,801,1432,-3109,-570,814,-2559,4568,-2563,3954,2533,-218,922,-1103,293,-4535,3676,1657,1315,-3545,2621,2113,2475,-3247,4964,-3469,3333,-918,-2469,-1246,2429,-4675,3789,-640,-3135,797,-4116,506,1400,-2750,-3174,22,3193,3358,40,1103,-1830,574,1752

	.globl main
	.globl root
	.globl push
	.globl mergeSort
	.globl mergeUp
	.globl splitHalf
	.globl printList
	.globl importList

	.text
############
#   main   #
############

main:

	# (your code here)
	la $a0, randnums        # grab array starting memory address 
	
	la $t1, arrLen          # grab the array length from memory
	lw $a1, 0($t1)
	
	#addi $a1, $zero, 20    # load the first 20 elements for testing
	
	addi $sp, $sp, -4       # shift stack register and push 
	sw $ra, 4($sp)          # $ra onto it

	jal importList          # import the list from the given array

	addu $s7, $v0, $0       #save linked list head
	
	la $a0, printIntro      # print out preamble to printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0       # restore $a0 to linked list header
                            # before calling printList

	jal printList

	addu $a0, $s7, $0       # no guarantees printList didn't affect
                            # $a0, so reload from saved point
	jal mergeSort
	
	addu $s7, $v0, $0       #save the new linked list head 
	
	la $a0, printSorted     # print out preamble to sorted printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0       # restore $a0 to linked list header
                            # before calling printList

	jal printList
	
	lw $ra, 4($sp)          # pop the stack to restore $ra 
	addi $sp, $sp, 4        # increment stack pointer to release memory for reuse
	
	# return to caller
	jr 	$ra


#################
#   root_node   #
#################

root:
	# (Establishes the original node)
	# $a0 holds the value to store
	# use sbrk to find the next free part of heap 
	# $v0 returns the new head of the linked list

    move $t0, $a0       #save arguments to temp

    li $v0, 9           #sbrk
    li $a0, 8           #size = 4 bytes data + 4 bytes pointer address
    syscall             #v0 <- new obj

    sw $t0, 0($v0)      #assign value
    sw $zero, 4($v0)    #assign pointer	

	# return to caller
    jr 	$ra


#################
#   push_node   #
#################

push:
	# Pushes a new node on to the top of the linked list
	# use sbrk to find the next free part of heap 
	# $a0 holds the value to store
	# $a1 holds the head of the linked list
	# $v0 holds the new head of the linked list
    
    move $t0, $a0       #save arguments to temp

    li $v0, 9           #sbrk
    li $a0, 8           #size = 4 bytes data + 4 bytes pointer address
    syscall             #v0 <- new obj

    sw $t0, 0($v0)      #assign value
    sw $a1, 4($v0)      #assign pointer	

	# return to caller
	jr 	$ra


#################
#  Merge_Sort   #
#################

mergeSort:

	# Break linked list into fragments recursively and then
	# reassemble nodes into sequentially increasing linked list
	# This sort must maintain stability
	# $a0 holds the address of the top of the linked list
	# $v0 holds the header of the sorted merge

    addi $sp, $sp, -20          #expand sp by 20
    sw $ra, 4($sp)              #push ra
    sw $s0, 8($sp)              #push s0
    sw $s1, 12($sp)             #push s1
    sw $s2, 16($sp)             #push s2
    sw $s3, 20($sp)             #push s3

    bnez $a0, headNULL1         #if(head==NULL) return head address
    move $v0, $a0               #return head address in v0
    j recursiveEnd              #exit recursive

headNULL1:
    lw $s0, 4($a0)              #load head->next to s0
    bnez $s0, recursive         #if(head->next==NULL) return head address
    move $v0, $a0               #return head address in v0
    j recursiveEnd              #exit recursive

recursive:
    jal splitHalf               #splitHalf(a0) return two list head in v0, v1
    move $s2, $v0               #save v0 -> s2
    move $s3, $v1               #save v1 -> s3

    move $a0, $s2               #prepare left half head address to a0
    jal mergeSort               #mergeSort(a0) return sorted address in v0
    move $s0, $v0               #save v0 -> s0

    move $a0, $s3               #prepare right half head address to a0
    jal mergeSort               #mergeSort(a0) return sorted address in v0
    move $s1, $v0               #save v0 -> s1

    move $a0, $s0               #prepare a0 from s0
    move $a1, $s1               #prepare a1 from s1
    jal mergeUp                 #mergeUp(a0, a1) return sorted address in v0

recursiveEnd:
	# return to caller
    lw $ra, 4($sp)              #pop ra
    lw $s0, 8($sp)              #pop s0
    lw $s1, 12($sp)             #pop s1
    addiu $sp, $sp, 20          #shrink sp by 20
	jr 	$ra

###################
#     mergeUp     #
###################

mergeUp:
	# Merges the two sublists into a single sorted list
	# $a0 contains head address of first sub-list (A)
	# $a1 contains head address of second sub-list (B)
	# $v0 returns the head address of the combined list

    addi $sp, $sp, -20          #expand sp by 20
    sw $ra, 4($sp)              #push ra
    sw $s0, 8($sp)              #push s0

    #if(Left==NULL) return Right
    bnez $a0, LNotNull          #branch not equal to zero
    move $v0, $a1               #return head in v0
    j endMergeUp
LNotNull:                       #endIF

    #if(Right==NULL) return Left
    bnez $a1, RNotNull          #branch not equal to zero
    move $v0, $a0               #return head in v0
    j endMergeUp
RNotNull:                       #endIF

    #if(Left->data <= Right->data)
    lw $t0, 0($a0)              #load data from Left
    lw $t1, 0($a1)              #load data from Right
    
    bgt $t0, $t1, RGreatL       #branch greater than
    move $s0, $a1               #save head

    sw $a1, 12($sp)             #push a1
    lw $a1, 4($a1)              #prepare Right->next
    jal mergeUp                 #recursive mergeUp(Left, Right->next)
    lw $a1, 12($sp)             #pop a1
    sw $v0, 4($s0)              #head->next = mergeUp(Left, Right->next)

RGreatL:
    move $s0, $a0               #save head

    sw $a0, 12($sp)             #push a0
    lw $a0, 4($a0)              #prepare Left->next
    jal mergeUp                 #recursive mergeUp(Left->next, Right)
    lw $a0, 12($sp)             #pop a0
    sw $v0, 4($s0)              #head->next = mergeUp(Left->next, Right)

    move $v0, $s0               #return head in v0

endMergeUp:
	# return to caller
    lw $ra, 4($sp)              #pop ra
    lw $s0, 8($sp)              #pop t0
    addiu $sp, $sp, 20          #shrink sp by 20
	jr 	$ra

#############
# splitHalf #
#############

splitHalf:

	# Splits a linked list into two equal halves by 
	# advancing through the linked list at two different
	# speeds (fast and slow).
	# $a0 contains head address linked list
	# $v0 returns the head address of first sub-list
	# $v1 returns the head address of second sub-list

    addi $sp, $sp, -20          #expand sp by 20
    sw $ra, 4($sp)              #push ra
    sw $s0, 8($sp)              #push s0
    sw $s1, 12($sp)             #push s1
    sw $s2, 16($sp)             #push s2

    # t0 for NULL bool value
    # s0 for head->next

    bnez $a0, headNULL2         #if(head==NULL) return head address
    move $v0, $a0               #return head address in v0
    move $v1, $zero             #return NULL in v1
    j endSplitHalf              #exit splitHalf

headNULL2:
    lw $s0, 4($a0)              #load head->next to s0
    bnez $s0, moreThanOne       #if(head->next==NULL) return head address
    move $v0, $a0               #return head address in v0
    move $v1, $zero             #return NULL in v1
    j endSplitHalf              #exit splitHalf

moreThanOne:
    # s1 for slow iterator
    # s2 for fast iterator

    move $s1, $a0               #copy head to slow iterator
    lw $s2, 4($a0)              #copy head->next to fast iterator

    beqz $s2, endIteratorWhile  #while(fast!=NULL)
iteratorWhile:
    lw $s2, 4($s2)              #fast = fast->next

    beqz $s2, fastNotNULL       #if(fast!=NULL)
    lw $s2, 4($s2)                #fast = fast->next
    lw $s1, 4($s1)                #slow = slow->next
fastNotNULL:                    #endIF

    bnez $s2, iteratorWhile     #if(fast==NULL) repeat loop
endIteratorWhile:

    lw $s0, 4($s1)              #get slow->next for return
    sw $zero, 4($s1)            #assign NULL to slow->next

    move $v0, $a0               #return head (Left) to v0
    move $v1, $s0               #return slow->next (Right) to v1

endSplitHalf:
	# return to caller
    lw $ra, 4($sp)              #pop ra
    lw $s0, 8($sp)              #pop s0
    lw $s1, 12($sp)             #pop s1
    lw $s2, 16($sp)             #pop s2
    addiu $sp, $sp, 20          #shrink sp by 20
	jr $ra

################
#  print_list  #
################

printList:

	# Prints the data in list from head to tail
	# $a0 contains head address of list

	addu $t0, $a0, $zero        # since $a0 is used for syscalls, 
                                # move pointer to temp register

printloop:

	beq $t0, $zero, printDone   # jump out once end of list found
	lw $t1, 4($t0)              # grab next pointer and store in $t1
	lw $a0, 0($t0)              # grab value at present node
	addiu $v0, $zero, 1         # prepare to print integer
	syscall
	
	la $a0, printComma          # load comma and print string
	addiu $v0, $zero, 4
	syscall
	
	addu $t0, $t1, $zero        # move next pointer into $t0 for next loop
	j printloop

printDone:
	la $a0, printNL             # load newling character and print
	addiu $v0, $zero, 4
	syscall

	# return to caller
	jr 	$ra

#################
#  import_list  #
#################

importList:
    # $a0 holds array address
    # $a1 holds array length
    # $v0 returns header to linked list

    addi $sp, $sp, -20              #expand stack by 20
    sw $ra, 4($sp)                  #push ra
    sw $s0, 8($sp)                  #push s0
    
    #push first by root funciton
    sw $a0, 12($sp)                 #push a0
    lw $a0, 0($a0)                  #load value from address a0 -> a0
    jal root                        #return head address in v0
    lw $a0, 12($sp)                 #pop a0
    addiu $a0, $a0, 4               #increament to next element

    #loop push from 2nd to last element
    li $s0, 1                       #set i = 1, as the 2nd element

    beq $t0, $a1 whileImportEnd     #while(i < size)
whileImport:
    sw $a0, 12($sp)                 #push a0
    sw $a1, 16($sp)                 #push a1

    lw $a0, 0($a0)                  #load value from address a0 -> a0
    move $a1, $v0                   #load head from v0 to a1
    jal push                        #push(a0, a1) return head address in v0

    lw $a0, 12($sp)                 #pop a0
    lw $a1, 16($sp)                 #pop a1

    addiu $s0, 1                    #i++
    addiu $a0, 4                    #element address++
    bne $s0, $a1, whileImport       #while(i < size)
whileImportEnd:

    # return to caller
    lw $ra, 4($sp)                  #pop ra
    lw $s0, 8($sp)                  #pop s0
    addiu $sp, $sp, 20              #shrink stack
	jr $ra

	




