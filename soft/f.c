#include <stdio.h>
#include <stdint.h>

typedef union {
	float f;
	uint32_t ui;
} fvalue_u ;

int main(void){
	fvalue_u aa;
	int i;
	for (i;i<256;i++){
		aa.f = i;
		aa.f /= 255.0;
//		printf("%08x\n", aa.ui);
		printf("0x%08x,\n", aa.ui);
	}

}
