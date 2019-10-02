#include <stdlib.h>
#include <stdio.h>

int main(void){
	int n;
	printf("Digite o tamanho do vetor: ");
	scanf("%i", &n);
	int v[n];
	for(int i = 0; i<n; i++){
		printf("digite o valor %i:", i);
		scanf("%i", &v[i]);
	}
	int value;
	for(int i=0; i<n; i++) printf("%i, ", v[i]);
	printf("\n");
	printf("digite o valor a ser excluído:");
	scanf("%i", &value);
	int remCnt = 0, oldSize = n;
	for(int k = 0; k<=n; k++)
		for(int i = 0; i<=n; i++){
			if(v[i] == value){
				remCnt++;
				if( i+1 < n ){
					for(int j = i; j<n; j++) v[j] = v[j+1];
				}
				n--;
			}
		}
	for(int i = n; i<n; i++) v[i] = 0;
	if(remCnt == 0) printf("Não há elementos para remover.");
	else{
		printf("n: %i\n", n);
		for(int i=0; i<n; i++) printf("%i, ", v[i]);
		printf("\n");
	}
}
