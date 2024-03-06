.data
a: .word 1, 2, 3, 4, 5
b: .word 6, 7, 8, 9, 10
sum: .string "The dot product is: "
newline: .string "\n"

.text
main:
    li s0, 0            # result = s0
    la a0, a            # a0 = a
    la a1, b            # a2 = b
    li a2, 5            # len = 5
    mv s0, a0 # move result from a0 to s0
    jal dot_product_recursive
    mv s1, a0

    # print result

    addi a0, zero, 4
    la, a1, sum
    ecall

    addi a0, zero, 1
    mv a1, s1
    ecall

    addi a0, zero, 4 
    la, a1, newline
    ecall

    addi a0, x0, 10
    addi a1, x0, 0
    ecall # Terminate ecall

dot_product_recursive:
    lw t1, 0(a0) # t1 = a[0]
    lw t2, 0(a1) # t2 = b[0]
    mul t3, t1, t2 # a[0] * b[0]
    addi t0, x0, 1 # t0 = 1
    beq a2, t0, exit_base_case     # if_ a2 == 1 jump to exit_base_case
    
    # save return address
    addi sp, sp, -4
    sw  ra, 0(sp)

    # a0 = a+1
    # a1 = b+1
    # a2 = size-1
    addi a0, a0, 4
    addi a1, a1, 4
    addi a2, a2, -1
    # save t3
    addi sp, sp, -4
    sw  t3, 0(sp)

    jal dot_product_recursive

    lw t3, 0(sp)
    addi sp, sp, 4

    add a0, a0, t3

    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra

exit_base_case:
    mul a0, t1, t2 
    jr ra