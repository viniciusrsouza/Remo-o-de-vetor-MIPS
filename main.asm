.data 
msg_tam: 	  	.asciiz "Digite o tamanho do vetor(1 a 15):\n"
msg_erro_tamanho: 	.asciiz "Tamanho inválido.\n"
msg_receber_inteiro: 	.asciiz "Digite um número inteiro.\n"
msg_receber_excluir:	.asciiz "Digite o valor a ser removido.\n"
msg_n_encontrado:	.asciiz "O número selecionado não existe no vetor. \n"

#  Registradores
#  $s0 = tamanho do vetor
#  $s1 = endereço do vetor
#  $s2 = valor a ser excluído
#  $s3 = valor de $s2 existe no vetor
#

.text
main:
ler_tamanho:
	# Imprime mensagem solicitando o tamanho do vetor.
	li $v0, 4
	la $a0, msg_tam
          syscall
        
     	# Recebe o tamanho e salva em $s0.
     	li $v0, 5
     	syscall
     	move $s0, $v0  
     	
     	# Verifica se o valor digitado é valido.
     	addi $t1, $zero, 15
    	slti $t0, $s0, 1                #(tamanho digitado < 1)?
     	beq $t0, 1, imprime_erro_tam   
     	slt $t0, $t1, $s0               #(15 < tamanho digitado)?
     	beq $t0, 1, imprime_erro_tam  
          
     	j inicializar_vetor
     	
imprime_erro_tam:      # Imprime mensagem de erro e volta para ler_tamanho.
          li $v0, 4
          la $a0, msg_erro_tamanho
          syscall
          j ler_tamanho
        
inicializar_vetor:	
	mul $a0, $s0, 4       	#
	li $v0, 9	      	#
	syscall         	#    Aloca o espaço necessário e salva o endereço em $s1.
	move $s1, $v0	        #          
	addi $t0, $zero, 0	#zera o $t0, para ser usado como contador no loop
          
loop_ler_elementos:     	#loop usa $t0 como contador
	beq $t0, $s0, remover_elemento	# (contador = tamanho do vetor)? 
	   
          li $v0, 4                     #
          la $a0, msg_receber_inteiro   #                                          
          syscall                       #  Solicita um inteiro e salva em $v0
          li $v0, 5                     #                                          
          syscall                       #
     	
     	mul $t3, $t0, 4                 #    
     	add $t2 , $t3, $s1              #   Salva o número recebido no vetor
     	sw $v0, 0($t2)                  #  
  
          addi $t0, $t0, 1              #Incrementa o contador
          j loop_ler_elementos
          
remover_elemento:
	li $v0, 4
	la $a0, msg_receber_excluir
	syscall
	li $v0, 5
	syscall
	add $s2, $v0, $zero	# armazena o valor que será excluído em $s2
	addi $t4, $s0, 1	# carrega n+1 em $t4 para facilitar comparações
	add $t2, $zero, $zero	# zera $t2 para usar no laço
	loop_rem_1:
	  beq $t2, $t4, end1	# $t2 == n+1
  	  add $t5, $zero, $zero	# zera $t5 para usar no laço
	  add $t0, $s1, $zero	# carrega o endereço inicial do vetor em $t0
	  loop_rem_2:
	    beq $t5, $t4, end2	# $t5 == n+1
	    lw $t6, 0($t0)	# armazena v[$t5] em $t6
	    bne $t6, $s2, else
	      addi $s3, $zero, 1 # $s3 = true
	      addi $t7, $t5, 1   # $t5+1
	      slt $t7, $t7, $t5
	      bnez $t7, else
	      # for(int j = i; j<n; j++) v[j] = v[j+1];
	      add $a1, $zero, $zero  # carrega $a1 para usar no laço
	      sub $sp, $sp, 4	     # push $t0 para a stack
	      sw $t0, 0($sp)
	      loop_remover:
	      	beq $a1, $s0, end_remover
	        lw $t3, 4($t0)
	        sw $t3, 0($t0)
	        addi $t0, $t0, 4
	        addi $a1, $a1, 1
	        j loop_remover
	      end_remover:
	      lw $t0, 0($sp)	     # pop stack para $t0
	      addi $sp, $sp, 4
	      
	    else:
	    addi $t0, $t0, 4
	    addi $t5, $t5, 1
	    j loop_rem_2
	  end2:
	  addi $t2, $t2, 1
	  j loop_rem_1
	end1:
	bne $s3, 0, else_not_found
	addi $v0, $zero, 4
	la $a0, msg_n_encontrado
	syscall
	else_not_found:
	
	addi $v0, $zero, 17
	syscall
		
	
