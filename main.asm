.data 
     tam: .asciiz "Digite o tamanho do vetor: "
.text
     main:
          # Imprime mensagem solicitando o tamanho do vetor.
          li $v0, 4
          la $a0, tam
          syscall
     
          # Recebe o valor digitado.
          li $v0, 5
          syscall
