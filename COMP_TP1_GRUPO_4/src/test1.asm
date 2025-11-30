# ===== SEÇÃO DE DADOS =====
.data
  input:    .space 100       # Buffer para entrada
  newline:  .asciiz "\n"    # String para nova linha
  true_str: .asciiz "true"  # String para true
  false_str:.asciiz "false" # String para false

# ===== SEÇÃO DE CÓDIGO =====
.text
.globl main
main:
  move $t0, $s3       # t0 = (x > 5)
  beqz $t0, L0     # IFZ t0
  la $a0, str_-6519028256589810582         # String: x is greater than 5
  move $a0, $a0              # PARAM "x is greater than 5"
  li $v0, 4                   # Put_Line string
  syscall
  la $a0, newline            # Nova linha
  li $v0, 4
  syscall

  j L1                   # GOTO
L0:                          # RÓTULO
  la $a0, str_6594752561583024125         # String: x is 5 or less
  move $a0, $a0              # PARAM "x is 5 or less"
  li $v0, 4                   # Put_Line string
  syscall
  la $a0, newline            # Nova linha
  li $v0, 4
  syscall

L1:                          # RÓTULO
L2:                          # RÓTULO
  move $t1, $s4       # t1 = (x > 0)
  beqz $t1, L3     # IFZ t1
  move $t2, $s4       # t2 = (x - 1)
  move $s1, $t2       # x = t2
  j L2                   # GOTO
L3:                          # RÓTULO

# ===== FINALIZAÇÃO DO PROGRAMA =====
  li $v0, 10                 # Syscall para exit
  syscall
