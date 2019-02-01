//#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <iostream>

#define FPGA_ACTIVE
#define FPGA_ACTIVE2
//#define DEBUG

uint32_t fconv[256] = {
0x00000000,
0x3b808081,
0x3c008081,
0x3c40c0c1,
0x3c808081,
0x3ca0a0a1,
0x3cc0c0c1,
0x3ce0e0e1,
0x3d008081,
0x3d109091,
0x3d20a0a1,
0x3d30b0b1,
0x3d40c0c1,
0x3d50d0d1,
0x3d60e0e1,
0x3d70f0f1,
0x3d808081,
0x3d888889,
0x3d909091,
0x3d989899,
0x3da0a0a1,
0x3da8a8a9,
0x3db0b0b1,
0x3db8b8b9,
0x3dc0c0c1,
0x3dc8c8c9,
0x3dd0d0d1,
0x3dd8d8d9,
0x3de0e0e1,
0x3de8e8e9,
0x3df0f0f1,
0x3df8f8f9,
0x3e008081,
0x3e048485,
0x3e088889,
0x3e0c8c8d,
0x3e109091,
0x3e149495,
0x3e189899,
0x3e1c9c9d,
0x3e20a0a1,
0x3e24a4a5,
0x3e28a8a9,
0x3e2cacad,
0x3e30b0b1,
0x3e34b4b5,
0x3e38b8b9,
0x3e3cbcbd,
0x3e40c0c1,
0x3e44c4c5,
0x3e48c8c9,
0x3e4ccccd,
0x3e50d0d1,
0x3e54d4d5,
0x3e58d8d9,
0x3e5cdcdd,
0x3e60e0e1,
0x3e64e4e5,
0x3e68e8e9,
0x3e6ceced,
0x3e70f0f1,
0x3e74f4f5,
0x3e78f8f9,
0x3e7cfcfd,
0x3e808081,
0x3e828283,
0x3e848485,
0x3e868687,
0x3e888889,
0x3e8a8a8b,
0x3e8c8c8d,
0x3e8e8e8f,
0x3e909091,
0x3e929293,
0x3e949495,
0x3e969697,
0x3e989899,
0x3e9a9a9b,
0x3e9c9c9d,
0x3e9e9e9f,
0x3ea0a0a1,
0x3ea2a2a3,
0x3ea4a4a5,
0x3ea6a6a7,
0x3ea8a8a9,
0x3eaaaaab,
0x3eacacad,
0x3eaeaeaf,
0x3eb0b0b1,
0x3eb2b2b3,
0x3eb4b4b5,
0x3eb6b6b7,
0x3eb8b8b9,
0x3ebababb,
0x3ebcbcbd,
0x3ebebebf,
0x3ec0c0c1,
0x3ec2c2c3,
0x3ec4c4c5,
0x3ec6c6c7,
0x3ec8c8c9,
0x3ecacacb,
0x3ecccccd,
0x3ecececf,
0x3ed0d0d1,
0x3ed2d2d3,
0x3ed4d4d5,
0x3ed6d6d7,
0x3ed8d8d9,
0x3edadadb,
0x3edcdcdd,
0x3edededf,
0x3ee0e0e1,
0x3ee2e2e3,
0x3ee4e4e5,
0x3ee6e6e7,
0x3ee8e8e9,
0x3eeaeaeb,
0x3eececed,
0x3eeeeeef,
0x3ef0f0f1,
0x3ef2f2f3,
0x3ef4f4f5,
0x3ef6f6f7,
0x3ef8f8f9,
0x3efafafb,
0x3efcfcfd,
0x3efefeff,
0x3f008081,
0x3f018182,
0x3f028283,
0x3f038384,
0x3f048485,
0x3f058586,
0x3f068687,
0x3f078788,
0x3f088889,
0x3f09898a,
0x3f0a8a8b,
0x3f0b8b8c,
0x3f0c8c8d,
0x3f0d8d8e,
0x3f0e8e8f,
0x3f0f8f90,
0x3f109091,
0x3f119192,
0x3f129293,
0x3f139394,
0x3f149495,
0x3f159596,
0x3f169697,
0x3f179798,
0x3f189899,
0x3f19999a,
0x3f1a9a9b,
0x3f1b9b9c,
0x3f1c9c9d,
0x3f1d9d9e,
0x3f1e9e9f,
0x3f1f9fa0,
0x3f20a0a1,
0x3f21a1a2,
0x3f22a2a3,
0x3f23a3a4,
0x3f24a4a5,
0x3f25a5a6,
0x3f26a6a7,
0x3f27a7a8,
0x3f28a8a9,
0x3f29a9aa,
0x3f2aaaab,
0x3f2babac,
0x3f2cacad,
0x3f2dadae,
0x3f2eaeaf,
0x3f2fafb0,
0x3f30b0b1,
0x3f31b1b2,
0x3f32b2b3,
0x3f33b3b4,
0x3f34b4b5,
0x3f35b5b6,
0x3f36b6b7,
0x3f37b7b8,
0x3f38b8b9,
0x3f39b9ba,
0x3f3ababb,
0x3f3bbbbc,
0x3f3cbcbd,
0x3f3dbdbe,
0x3f3ebebf,
0x3f3fbfc0,
0x3f40c0c1,
0x3f41c1c2,
0x3f42c2c3,
0x3f43c3c4,
0x3f44c4c5,
0x3f45c5c6,
0x3f46c6c7,
0x3f47c7c8,
0x3f48c8c9,
0x3f49c9ca,
0x3f4acacb,
0x3f4bcbcc,
0x3f4ccccd,
0x3f4dcdce,
0x3f4ececf,
0x3f4fcfd0,
0x3f50d0d1,
0x3f51d1d2,
0x3f52d2d3,
0x3f53d3d4,
0x3f54d4d5,
0x3f55d5d6,
0x3f56d6d7,
0x3f57d7d8,
0x3f58d8d9,
0x3f59d9da,
0x3f5adadb,
0x3f5bdbdc,
0x3f5cdcdd,
0x3f5dddde,
0x3f5ededf,
0x3f5fdfe0,
0x3f60e0e1,
0x3f61e1e2,
0x3f62e2e3,
0x3f63e3e4,
0x3f64e4e5,
0x3f65e5e6,
0x3f66e6e7,
0x3f67e7e8,
0x3f68e8e9,
0x3f69e9ea,
0x3f6aeaeb,
0x3f6bebec,
0x3f6ceced,
0x3f6dedee,
0x3f6eeeef,
0x3f6feff0,
0x3f70f0f1,
0x3f71f1f2,
0x3f72f2f3,
0x3f73f3f4,
0x3f74f4f5,
0x3f75f5f6,
0x3f76f6f7,
0x3f77f7f8,
0x3f78f8f9,
0x3f79f9fa,
0x3f7afafb,
0x3f7bfbfc,
0x3f7cfcfd,
0x3f7dfdfe,
0x3f7efeff,
0x3f800000,
};

typedef struct{
	uint32_t ctrl;
	uint32_t mif;
	uint32_t read_address;
	uint32_t write_address;
	uint32_t xsize;
	uint32_t ysize;
	uint32_t start_delay;
	uint32_t nouse[8];
	uint32_t bias;
} fpga0_reg;

typedef struct{
	uint32_t ctrl;
	uint32_t mif;
	uint32_t read_address;
	uint32_t write_address;
	uint32_t xsize;
	uint32_t ysize;
	uint32_t w[9];
	uint32_t bias;
} fpga1_reg;

typedef struct{
	fpga0_reg fx;
	fpga1_reg fi[4];
} fpga_reg;

static volatile fpga_reg *zcnn;

void *p_fpga_map;
void *p_fpga_mem;
static volatile uint32_t *fpga_map;
static volatile uint32_t *fpga_mem;
int32_t fd;

#define LW_PAGE_SIZE 65536*4
#define LWHPS2FPGA_BRIDGE_BASE 0xff200000

#define PAGE_SIZE 65536*1024*4
#define HPS2FPGA_BRIDGE_BASE   0xC0000000

void fpga_open(void){

	fd = open("/dev/mem", O_RDWR|O_SYNC);
	if (fd < 0) {
		perror("open");
		exit(EXIT_FAILURE);
	}

	/* map the HPS2FPGA bridge into process memory */
	p_fpga_map = mmap(NULL, LW_PAGE_SIZE, PROT_WRITE, MAP_SHARED, fd, LWHPS2FPGA_BRIDGE_BASE);
	if (p_fpga_map == MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}

	p_fpga_mem= mmap(NULL, PAGE_SIZE, PROT_WRITE, MAP_SHARED,fd, HPS2FPGA_BRIDGE_BASE);
	if (p_fpga_mem== MAP_FAILED) {
		perror("mmap");
		exit(EXIT_FAILURE);
	}
  	close(fd);

	fpga_map = (volatile uint32_t*) p_fpga_map;
	fpga_mem = (volatile uint32_t*) p_fpga_mem;

	zcnn = (volatile fpga_reg *) fpga_map;
}

void fpga_close(void)
{
    if(-1 == munmap(p_fpga_map, LW_PAGE_SIZE)){
    // Error hanlder
    }
    if(-1 == munmap(p_fpga_mem, PAGE_SIZE)){
    // Error hanlder
    }
}


void	fpconv_data_copy_to_fpga (uint8_t *input_ptr,
								  uint32_t offset,
								  uint32_t copy_size
){
	int i;
	uint8_t *pp;
	uint32_t *di;
	uint32_t *dp;
	uint32_t *mem;
	di = (uint32_t *)malloc(sizeof(uint32_t)*copy_size);

	#ifdef DEBUG
	uint8_t *dd;
	dd = (uint8_t *)malloc(sizeof(uint8_t)*copy_size);
	uint8_t *ddp;
	uint32_t gg;
	FILE *fp;
	fp = fopen("99999.out","r");
	ddp = dd;
	for(i=0;i<int(copy_size);i++){
		fscanf(fp,"%d",&gg);
		*ddp = gg;
		ddp++;
	}
	pp = dd;
	#else
	pp = input_ptr;
	#endif
	dp = di;
	for(i=0;i<int(copy_size);i++){
		*dp = fconv[*pp];
		dp++; pp++;
	}

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)mem,(void*)dp,sizeof(uint32_t)*copy_size);
	free(di);
}

union tf_t {float f;uint32_t ui;};
void	intconv_data_copy_from_fpga (uint8_t *input_ptr,
								   uint32_t offset,
								   uint32_t copy_size
){
	int i;
	uint8_t *pp;
	uint32_t *di;
	uint32_t *dp;
	uint32_t *mem;
	uint32_t td;
	tf_t tf;

	di = (uint32_t *)malloc(sizeof(uint32_t)*copy_size);

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)dp,(void*)mem,sizeof(uint32_t)*copy_size);

	dp = di;
	pp = input_ptr;
	for(i=0;i<int(copy_size);i++){
		tf.ui = *dp;
		if (i==0){
			printf("%08x %d\n",tf.ui,offset);
		}
		if (tf.f>=1.0){
			tf.f = 1.0;
		}else if(tf.f<0.0){
			tf.f = 0.0;
		}
		td = tf.f*255;
		*pp = td & 0xff;
		dp++; pp++;
	}

	free(di);
}

void	debug_mem_put (const char *str,
					   uint32_t offset,
					   uint32_t copy_size
){
	FILE *dfp;
	int i;
	uint32_t *di;
	uint32_t *dp;
	uint32_t *mem;
	tf_t tf;

	dfp = fopen(str,"w");

	di = (uint32_t *)malloc(sizeof(uint32_t)*copy_size);

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)dp,(void*)mem,sizeof(uint32_t)*copy_size);

	dp = di;
	for(i=0;i<int(copy_size);i++){
		tf.ui = *dp;
        fprintf(dfp,"%f , %d\n",tf.f,tf.ui);
		dp++;
	}
	fclose(dfp);

	free(di);
}
void	debug_dump_reg (const char *str
){
	FILE *dfp;
	volatile uint32_t *zp;
	int i;
	zp = &zcnn->fx.ctrl;
	dfp = fopen(str,"w");
	for(i=0;i<16*5;i++){
		fprintf (dfp,"reg_avl.op_write(16'h%04x,32'h%08x);\n",i,*zp);
		zp++;
	}
	fclose(dfp);
}

int main(int argc, char* argv[]){
    double t = 0;
    t = (double)cvGetTickCount();

	FILE *pp,*bp,*wp;
	int i,j,k,l;
#ifdef FPGA_ACTIVE
	fpga_open();
#endif
	if (argc!=2){
		printf("----------------------------------------------------------------%d\n",argc);
		printf("waifu2x_fpga [input picture]\n");
		return -1;
	}

	if ((pp = fopen("plane.txt","r")   ) == NULL){
		printf("plane.txt open Error!!!\n");
		return -1;
	}
	if ((bp = fopen("bias.bin","rb")   ) == NULL){
		printf("bias.bin open Error!!!\n");
		return -1;
	}
	if ((wp = fopen("weight.bin","rb") ) == NULL){
		printf("weight.bin open Error!!!\n");
		return -1;
	}

	//loop factor read
	int factor_loop;
	int max_input_planes;
	fscanf(pp,"%d",&factor_loop);
	int input_loop[factor_loop];
	int output_loop[factor_loop];

	max_input_planes = 0;
	for(i=0;i<factor_loop;i++){
		fscanf(pp,"%d %d",
			   &input_loop[i],
			   &output_loop[i]);
		if (max_input_planes<input_loop[i]){
			max_input_planes = input_loop[i];
		}
	}
	fclose(pp);

	//image read -> fpga memory write
	cv::Mat img = cv::imread(std::string(argv[1]), 1);
	cv::Mat img_yuv;

	//to yuv
	cv::cvtColor(img,img_yuv,CV_BGR2YCrCb);

	cv::Mat img2;
	cv::resize(img_yuv, img2, cv::Size(), 2.0 , 2.0 , cv::INTER_NEAREST);
	cv::Size img2_size = img2.size();

    std::vector<cv::Mat> color_planes;
	cv::split(img2, color_planes);
	
	//memory pointer calculate
	//odd / even * (max_input_planes)
	uint32_t fmp[2][max_input_planes];
	uint32_t pic1_size;
	pic1_size = img2_size.width * img2_size.height / 4 + 1;
  
	for(i=0;i<max_input_planes;i++){
		fmp[0][i] = pic1_size * (2*i);
		fmp[1][i] = pic1_size * (2*i+1);
	}

#ifdef FPGA_ACTIVE
	uint32_t last_pointer;
	//y data copy
	fpconv_data_copy_to_fpga(color_planes[0].data,
							 fmp[0][0]*4,                        //copy address
							 img2_size.width * img2_size.height //copy size
	);
	last_pointer = fmp[0][0];

//	debug_mem_put ("in.img",fmp[0][0]*4,img2_size.width * img2_size.height + 10);

	//others setting
	zcnn->fx.start_delay = 400; //1line delay
	zcnn->fx.xsize = img2_size.width;
	zcnn->fx.ysize = img2_size.height;
	zcnn->fi[0].xsize = img2_size.width;
	zcnn->fi[0].ysize = img2_size.height;
	zcnn->fi[1].xsize = img2_size.width;
	zcnn->fi[1].ysize = img2_size.height;
	zcnn->fi[2].xsize = img2_size.width;
	zcnn->fi[2].ysize = img2_size.height;
	zcnn->fi[3].xsize = img2_size.width;
	zcnn->fi[3].ysize = img2_size.height;

#ifdef FPGA_ACTIVE2
	//main loop
	int p1;
	int p2;
	uint32_t tw[9];
	uint32_t xb[128];
	tf_t tf;
	int oneshot = 0;
	int progress = 0;
	for(i=0;i<factor_loop;i++){
		printf("Factor:%d Start!\n",i);
		fread(xb,sizeof(uint32_t),output_loop[i],bp);
		for(j=0,p2=0;j<output_loop[i];j++){
			for(k=0,p1=0;k<input_loop[i];k++){
				progress++;
				//weight
				fread(tw,sizeof(uint32_t),9,wp);
				for(l=0;l<9;l++){
					zcnn->fi[p2].w[8-l] = tw[l];
				}

				if (input_loop[i]==1){
					//プレーンが1枚なのでリードはf0
					//プレーンが1枚なので並列書き込み

					zcnn->fi[p2].mif = 0; //clear

					zcnn->fi[p2].write_address = fmp[(i+1)%2][j]; //write address

					//h 全プレーン書き込みに対して
					zcnn->fi[p2].mif |= 0x10;
					//bias
					zcnn->fi[p2].bias = xb[j];

					p2++;
					if (p2==4 || (j==(output_loop[i]-1))){ //fpga start
						zcnn->fi[0].read_address = fmp[i%2][k]; //read address
						if (p2>=1){
							zcnn->fi[0].mif |= 2; //write on
						}
						if (p2>=2){
							zcnn->fi[1].mif |= 2; //write on
						}
						if (p2>=3){
							zcnn->fi[2].mif |= 2; //write on
						}
						if (p2>=4){
							zcnn->fi[3].mif |= 2; //write on
						}

						zcnn->fi[0].mif |= 1; //read mif on
						zcnn->fx.mif = 0; //clear
						zcnn->fx.ctrl = 0; //fx ctrl clear
						zcnn->fx.ctrl |= 0x10000; //f0 multi assign
						zcnn->fx.ctrl |= 1; //tg on
						while((zcnn->fx.ctrl & 2)!=0){
							//poling wait
						}
						#ifdef DEBUG
						if (oneshot==0){
							oneshot = 1;
							debug_mem_put ("0.img",0,img2_size.width * img2_size.height);
							debug_mem_put ("1.img",fmp[1][0]*4,img2_size.width * img2_size.height);
							debug_mem_put ("2.img",fmp[1][1]*4,img2_size.width * img2_size.height);
							debug_mem_put ("3.img",fmp[1][2]*4,img2_size.width * img2_size.height);
							debug_mem_put ("4.img",fmp[1][3]*4,img2_size.width * img2_size.height);
							debug_dump_reg ("reg.txt");
							last_pointer = fmp[1][0];
							//goto debug_put;
						}
						#endif
						p2 = 0; //clear
					}
				}else{
					//プレーンが複数枚なので加算モード

					zcnn->fi[p2].read_address  = fmp[i%2][k]; //read address
					zcnn->fi[p2].write_address  = fmp[i%2][k+1]; //read address

					p2++;
					if (p2==4 || (k==input_loop[i]-1)){ //fpga start

						zcnn->fx.read_address = fmp[(i+1)%2][j]; //add read address
						zcnn->fx.ctrl = 0; //clear
						zcnn->fx.mif = 0; //clear

						if (p1==0){ //複数枚の最初
							zcnn->fx.ctrl &= 0xfffffeff; //fx add off
							p1 = 1;
						}else{
							zcnn->fx.ctrl |= 0x00000100; //fx add on
							zcnn->fx.mif |= 1; //read on
						}

						//f0 add + read on
						if (p2>=1){
							zcnn->fx.ctrl |= 0x00000200;
							zcnn->fi[0].mif = 1; //read on
						}
						//f1 add + read on
						if (p2>=2){
							zcnn->fx.ctrl |= 0x00000400;
							zcnn->fi[1].mif = 1; //read on
						}
						//f2 add + read on
						if (p2>=3){
							zcnn->fx.ctrl |= 0x00000800;
							zcnn->fi[2].mif = 1; //read on
						}
						//f3 add + read on
						if (p2>=4){
							zcnn->fx.ctrl |= 0x00001000;
							zcnn->fi[3].mif = 1; //read on
						}

						zcnn->fx.write_address = fmp[(i+1)%2][j]; //write address
						last_pointer = fmp[(i+1)%2][j];

						//h 最終プレーン書き込みに対してのみ
						if (k==(input_loop[i]-1)){
							zcnn->fx.mif |= 0x10;
							//bias
							zcnn->fx.bias = xb[j];
						}
						zcnn->fx.mif |= 2; //write on
						zcnn->fx.ctrl |= 1; //tg on

						while((zcnn->fx.ctrl & 2)!=0){
							//poling wait
						}
						#ifdef DEBUG
						if (oneshot==1){
							oneshot = 2;
							debug_mem_put ("1t.img",fmp[(i+1)%2][j],img2_size.width * img2_size.height);
							debug_mem_put ("1h.img",zcnn->fi[0].write_address,img2_size.width * img2_size.height);
							debug_dump_reg ("reg_t.txt");
							//goto debug_put;
						}
						//else if (oneshot==2){
						else if (i==1 && j==1 && oneshot==2 && (k==(input_loop[i]-1))){
							oneshot = 3;
							debug_mem_put ("1x.img",fmp[(i+1)%2][j],img2_size.width * img2_size.height);
							debug_dump_reg ("reg.txt");
							//goto debug_put;
						}
						#endif
						p2 = 0; //clear
					}
				}
			}
		}
	}

#endif

					debug_put:
	intconv_data_copy_from_fpga(color_planes[0].data,
								last_pointer*4,                        //copy address
								img2_size.width * img2_size.height //copy size
	);

	fpga_close();
#endif

	cv::Mat img_dst;
	cv::Mat img_out;
	cv::merge(color_planes, img_dst);
	//to RGB
	cv::cvtColor(img_dst,img_out,CV_YCrCb2BGR);

	//preview
    cv::imshow( "result", img_out );    

    t = (double)cvGetTickCount() - t;
    printf( "time = %g ms\n", t/((double)cvGetTickFrequency()*1000.) );

	cv::waitKey(0);

	return 0;
}
