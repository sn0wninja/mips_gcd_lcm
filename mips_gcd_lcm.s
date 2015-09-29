# ------------------------------------------------
# CDA3101 Programming Assignment 2
# Artem Iryshkov UFID 2618-1472
# 09/23/15
# ------------------------------------------------
#
# MIPS GCD and LCM program -----------------------
#
# ------------------------------------------------

# Registers used:
#   $s0 = n1 (modified at runtime)
#   $s1 = n2 (modified at runtime)
#   $s2 = original n1
#   $s3 = original n2
#   $t0 = n1*n2 (LCM function)
#       $t0 = $s2 / $s3
#   $s4 = $t0 / $s0 <- GCD result
#   allocating 3 words on the stack
#   $ra, $s0, $s1
#   return address, n1, n2
# ------------------------------------------------

.data

# Console input messages
enter_n1: .asciiz "Enter first integer n1: "
enter_n2: .asciiz "Enter second integer n2: "

# Console results messages
gcd_msg: .asciiz "The greatest common divisor of n1 and n2 is "
lcm_msg: .asciiz "The least common multiple of n1 and n2 is: "
endl: .asciiz "\n\n"

.text

main:

    # Get input for n1:
    la $a0, enter_n1        #load mesage enter_n1
    li $v0, 4               #load print_str function
    syscall                 # make the syscall

    li $v0, 5               # load the read_int function
    syscall                 # make the syscall
    move $s0, $v0           # store the input in s0
    move $s2, $s0           # copy original n1

    # Get input for n2:
    la $a0, enter_n2        #load mesage enter_n2
    li $v0, 4               #load print_str function
    syscall

    li $v0, 5               # load the read_int function
    syscall                 # make the syscall
    move $s1, $v0           # store the input in s1
    move $s3, $s1           # copy original n2


calc_gcd:

    addiu $sp, $sp, -12     # allocate 3 words on the stack
    sw $ra, 8($sp)          # save the return address on the stack
    sw $s0, 4($sp)          # save n1 on the stack
    sw $s1, 0($sp)          # save n2 on the stack

    bnez $s1, ret_gcd             # go to calculate the GCD

    lw $s1, 0($sp)          # restore parameter n2
    lw $s0, 4($sp)          # restore parameter n1
    lw $ra, 8($sp)          # restore parameter $ra
    addi $sp,$sp,12         # deallocate the 3 words off the stack

    jal gcd_done            # we're done!

ret_gcd:

    div $s0, $s1            # computer n1/n2
    move $s0, $s1           # n1 = n2
    mfhi $s1                # grab the remainder
    jal calc_gcd            # return gcd(n2, n1%n2)

gcd_done:

    la $a0, gcd_msg         # load gcd_msg
    li $v0, 4               # load function print_string
    syscall                 # make the syscall

    move $a0, $s0           # load n1
    li $v0, 1               # load print int
    syscall                 # print n1

    # skip two lines to make the printing more neat
    la $a0, endl
    li $v0, 4
    syscall

    jal ret_lcm

ret_lcm:

    # LCM function to calculate least common multiple
    mult $s2, $s3
    mflo $t0
    div $t0, $s0
    mflo $s4

    la $a0, lcm_msg         # load lcm_msg
    li $v0, 4               # load function print_string
    syscall                 # make the syscall

    move $a0, $s4           # load s4
    li $v0, 1               # load print int
    syscall                 # print s4

    # skip two lines to make the printing more neat
    la $a0, endl
    li $v0, 4
    syscall

    j exit

exit:
    li $v0, 10
    syscall
