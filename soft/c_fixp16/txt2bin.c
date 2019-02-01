#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <math.h>

int s16(float d)
{
	double x;
	int ans;
	x = (double)d * pow(2,14);
	ans = x;
	return ans;
}

int s17(float d)
{
	double x;
	int ans;
	if (d>=1){
		printf("ERROR %f !!!\n",d);
	}
	x = (double)d * pow(2,14);
	ans = x;
	return ans;
}

int main(void){
	FILE *fp1, *bp1, *bt1;
	FILE *fp2, *bp2, *bt2;
	float ba;
	int bai;
	float we[9];
	int wei[9];

	fp1 = fopen("./bias.txt","r");
	bp1 = fopen("bias.bin","wb");
	bt1 = fopen("bias.out","w");

	fp2 = fopen("weight.txt","r");
	bp2 = fopen("weight.bin","wb");
	bt2 = fopen("weight.out","w");

	while(feof(fp1)==0){
		fscanf(fp1,"%f",&ba);
		bai = s16(ba);
		fwrite(&bai,sizeof(int),1,bp1);
		fprintf(bt1,"%f %08x\n",ba,bai);
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
		wei[0] = s17(we[0]);
		wei[1] = s17(we[1]);
		wei[2] = s17(we[2]);
		wei[3] = s17(we[3]);
		wei[4] = s17(we[4]);
		wei[5] = s17(we[5]);
		wei[6] = s17(we[6]);
		wei[7] = s17(we[7]);
		wei[8] = s17(we[8]);

		fwrite(wei,sizeof(int),9,bp2);
		fprintf(bt2,"%f %08x\n",we[0],wei[0]);
	}
	fclose(fp1);
	fclose(bp1);
	fclose(bt1);
	fclose(fp2);
	fclose(bp2);

	//make pointer
}
