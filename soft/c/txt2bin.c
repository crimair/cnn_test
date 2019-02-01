#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

typedef union {float f;unsigned int ui;}tf_t ;

int main(void){
	FILE *fp1, *bp1, *bt1;
	FILE *fp2, *bp2, *bt2;
	float ba;
	float we[9];
	tf_t tf;

	fp1 = fopen("./bias.txt","r");
	bp1 = fopen("bias.bin","wb");
	bt1 = fopen("bias.out","w");

	fp2 = fopen("weight.txt","r");
	bp2 = fopen("weight.bin","wb");

	while(feof(fp1)==0){
		fscanf(fp1,"%f",&ba);
		fwrite(&ba,sizeof(float),1,bp1);
		tf.f = ba;
		fprintf(bt1,"%f %08x\n",tf.f,tf.ui);
	}
	while(feof(fp2)==0){
		fscanf(fp2,"%f,%f,%f,%f,%f,%f,%f,%f,%f",
			   &we[0],
			   &we[1],
			   &we[2],
			   &we[3],
			   &we[4],
			   &we[5],
			   &we[6],
			   &we[7],
			   &we[8]
		);
		fwrite(we,sizeof(float),9,bp2);
	}
	fclose(fp1);
	fclose(bp1);
	fclose(bt1);
	fclose(fp2);
	fclose(bp2);

	//make pointer
}
