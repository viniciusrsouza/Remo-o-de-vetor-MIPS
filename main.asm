          .data 
msg_tam: 	  .asciiz "Digite o tamanho do vetor(1 a 15):\n"
msg_erro_tamanho: .asciiz "Tamanho inválido.\n"

          .text
main:
ler_tamanho:
          # Imprime mensagem solicitando o tamanho do vetor.
          li $v0, 4
          la $a0, msg_tam
          syscall
          # Recebe o valor digitado.
          li $v0, 5
          syscall
          # Verifica se o valor digitado é valido.
          li $t1, 15
          slti $t0, $v0, 1
          beq $t0, 1, imprime_erro_tam
          slt $t0, $t1, $v0 
          beq $t0, 1, imprime_erro_tam
          j ler_elementos
imprime_erro_tam:      # Mensagem de erro, retorna para ler_tamanho.
          li $v0, 4
          la $a0, msg_erro_tamanho
          syscall
          j ler_tamanho
ler_elementos:
