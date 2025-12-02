# ===== SEÇÃO DE DADOS =====

.data

  input:    .space 100

  newline:  .asciiz "\n"

  true_str: .asciiz "true"

  false_str:.asciiz "false"

  str_1: .asciiz "x is 5 or less"

  str_0: .asciiz "x is greater than 5"



# ===== SEÇÃO DE CÓDIGO =====

.text

.globl main

main:

  move $t0, $s0

  beqz $t0, L0

  la $a0, str_0

  move $a0, $a0

  li $v0, 4

  syscall

  li $v0, 4

  syscall

  la $a0, newline

  li $v0, 4

  syscall

  j L1

L0:

  la $a0, str_1

  move $a0, $a0

  li $v0, 4

  syscall

  li $v0, 4

  syscall

  la $a0, newline

  li $v0, 4

  syscall

L1:

L2:

  move $t1, $s3

  beqz $t1, L3

  move $t2, $s3

  move $s0, $t2

  j L2

L3:



# ===== FINALIZAÇÃO =====

  li $v0, 10

  syscall
