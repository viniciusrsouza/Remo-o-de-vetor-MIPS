	.data 
msg_tam: 	  	 .asciiz "Digite o tamanho do vetor(1 a 15):\n"
msg_erro_tamanho: 	 .asciiz "Tamanho inválido.\n"
msg_receber_inteiro: .asciiz "Digite um número inteiro.\n"

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
	mul $a0, $s0, 4       #
	li $v0, 9	             #
	syscall                #    Aloca o espaço necessário e salva o endereço em $s1.
	move $s1, $v0         #
          
	addi $t0, $zero, 0    #zera o $t0, para ser usado como contador no loop
          
loop_ler_elementos:     #loop usa $t0 como contador
	beq $t0, $s0, remover_elemento    # (contador = tamanho do vetor)? 
	   
          li $v0, 4                         #
          la $a0, msg_receber_inteiro        #                                          
          syscall                            #  Solicita um inteiro e salva em $v0
          li $v0, 5                          #                                          
          syscall                           #
     	
     	mul $t3, $t0, 4                   #    
     	add $t2 , $t3, $s1                 #   Salva o número recebido no vetor
     	sw $v0, 0($t2)                    #  
  
          addi $t0, $t0, 1                  #Incrementa o contador
          j loop_ler_elementos
          
remover_elemento:
