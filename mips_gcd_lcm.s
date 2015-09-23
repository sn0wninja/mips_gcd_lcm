# ------------------------------------------------
# CDA3101 Programming Assignment 2
# Artem Iryshkov UFID 2618-1472
# 09/23/15
# ------------------------------------------------
#
# MIPS GCD and LCM program -----------------------
#
# ------------------------------------------------
# li - load immediate int
# la - used to load the string messages for print
# move - used to save the inputs from the user
# div - divide
# mult - multiply
# j - jump to a function
# jr - jump register
# jr $ra - jump to register of last function
# ------------------------------------------------

# Registers used:
#   $t1 = n1
#   $t2 = n2
#
# ------------------------------------------------

.data

# Console input messages
enter_n1: .asciiz "Enter first integer n1: "
enter_n2: .asciiz "Enter second integer n2: "

# Console results messages
gcd_msg: .asciiz "The greatest common dividsor of n1 and n2 is "
lcm_msg: .asciiz "The least common multiple of n1 and n2 is: "

.text

main:

    # Get input for n1:
    la $a0, enter_n1        #load mesage enter_n1
    li $v0, 4               #load print_str function
    syscall                 # make the syscall

    li $v0, 5               # load the read_int function
    syscall                 # make the syscall
    move $t1, $v0           # store the input in t0

    # Get input for n2:
    la $a0, enter_n2        #load mesage enter_n2
    li $v0, 4               #load print_str function
    syscall

    li $v0, 5               # load the read_int function
    syscall                 # make the syscall
    move $t2, $v0           # store the input in t0

calc_gcd:

    beqz $t2,ret_gcd        

ret_gcd:
