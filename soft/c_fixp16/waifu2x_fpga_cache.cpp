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
#include <math.h>
#include <iostream>

#define FPGA_ACTIVE
#define FPGA_ACTIVE2
//#define DEBUG

int fp2int(float d)
{
	double x;
	int ans;
	x = (double)d * pow(2,16);
	ans = x;
	return ans;
}
float int2fp(int d)
{
	double x;
	x = (double)d / pow(2,16);
	return (float)x;
}
uint32_t byte2fp(uint8_t c)
{
	uint32_t cx;
	cx = c;
	cx = cx << 8;
	return cx;
}

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

typedef struct{
	int step_loop;
	int input_loop[128];
	int output_loop[128];
	int max_input_planes;
	uint32_t *bias_p;
	uint32_t *weights_p;
} cnn_param_t;

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

	pp = input_ptr;
	dp = di;
	for(i=0;i<int(copy_size);i++){
		*dp = byte2fp(*pp);
		if (i==0){
			printf("xxx %d %08x\n",*pp,byte2fp(*pp));
		}
		dp++; pp++;
	}

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)mem,(void*)dp,sizeof(uint32_t)*copy_size);
	free(di);
}

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
	int ia;
	float fa;

	di = (uint32_t *)malloc(sizeof(uint32_t)*copy_size);

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)dp,(void*)mem,sizeof(uint32_t)*copy_size);

	dp = di;
	pp = input_ptr;
	for(i=0;i<int(copy_size);i++){
		ia = *dp;
		fa = int2fp(ia);

		if (i==0){
			printf("%08x %d\n",ia,offset);
		}
		if (fa>=1.0){
			fa = 1.0;
		}else if(fa<0.0){
			fa = 0.0;
		}
		td = fa*255;
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
	int ia;
	float fa;

	dfp = fopen(str,"w");

	di = (uint32_t *)malloc(sizeof(uint32_t)*copy_size);

	dp = di;
	mem = (unsigned int *) (fpga_mem + (unsigned int)offset);
	memcpy((void*)dp,(void*)mem,sizeof(uint32_t)*copy_size);

	dp = di;
	for(i=0;i<int(copy_size);i++){
		ia = *dp;
		fa = int2fp(ia);
        fprintf(dfp,"%f , %d\n",fa,ia);
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

void convert_fpga(cv::Mat planes,cnn_param_t *lp){
	uint32_t fmp[2][lp->max_input_planes];
	uint32_t pic1_size;
	int i,j,k,l;

	fpga_open();

	cv::Size img_size = planes.size();
	pic1_size = img_size.width * img_size.height + 1;
  
	for(i=0;i<lp->max_input_planes;i++){
		fmp[0][i] = pic1_size * (2*i);
		fmp[1][i] = pic1_size * (2*i+1);
	}

	uint32_t last_pointer;
	//y data copy
	fpconv_data_copy_to_fpga(planes.data,
							 fmp[0][0]*4,                        //copy address
							 img_size.width * img_size.height //copy size
	);
	last_pointer = fmp[0][0];

	//others setting
	zcnn->fx.start_delay = 400; //1line delay
	zcnn->fx.xsize    = img_size.width;
	zcnn->fx.ysize    = img_size.height;
	zcnn->fi[0].xsize = img_size.width;
	zcnn->fi[0].ysize = img_size.height;
	zcnn->fi[1].xsize = img_size.width;
	zcnn->fi[1].ysize = img_size.height;
	zcnn->fi[2].xsize = img_size.width;
	zcnn->fi[2].ysize = img_size.height;
	zcnn->fi[3].xsize = img_size.width;
	zcnn->fi[3].ysize = img_size.height;

	//main loop
	int p1;
	int p2;
	uint32_t *tw = lp->weights_p;
	uint32_t *xb = lp->bias_p;
	int oneshot = 0;
	int progress = 0;
	
	for(i=0;i<lp->step_loop;i++){
		printf("Factor:%d Start!\n",i);
		for(j=0,p2=0;j<lp->output_loop[i];j++){
			for(k=0,p1=0;k<lp->input_loop[i];k++){
				progress++;
				//weight
				for(l=0;l<9;l++){
					zcnn->fi[p2].w[8-l] = *(tw++);
				}

				if (lp->input_loop[i]==1){
					//プレーンが1枚なのでリードはf0
					//プレーンが1枚なので並列書き込み

					zcnn->fi[p2].mif = 0; //clear

					zcnn->fi[p2].write_address = fmp[(i+1)%2][j]; //write address

					//h 全プレーン書き込みに対して
					zcnn->fi[p2].mif |= 0x10;
					//bias
					zcnn->fi[p2].bias = *(xb++);

					p2++;
					if (p2==4 || (j==(lp->output_loop[i]-1))){ //fpga start
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
						p2 = 0; //clear
					}
				}else{
					//プレーンが複数枚なので加算モード

					zcnn->fi[p2].read_address  = fmp[i%2][k]; //read address
					zcnn->fi[p2].write_address  = fmp[i%2][k+1]; //read address

					p2++;
					if (p2==4 || (k==lp->input_loop[i]-1)){ //fpga start

						zcnn->fx.read_address = fmp[(i+1)%2][j]; //add read address
						zcnn->fx.ctrl = 0; //clear
						zcnn->fx.mif = 0; //clear

						zcnn->fx.ctrl |= 0x00020000; //cache on

						if (p1==0){ //複数枚の最初
							zcnn->fx.ctrl &= 0xfffffeff; //fx add off
							p1 = 1;
						}else{
							zcnn->fx.ctrl |= 0x00000100; //fx add on
							//zcnn->fx.mif |= 1; //read on
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

						//h 最終プレーン書き込みに対してのみ (wbackも）
						if (k==(lp->input_loop[i]-1)){
							zcnn->fx.mif |= 0x10;
							//bias
							zcnn->fx.bias = *(xb++);
						}

						zcnn->fx.ctrl |= 1; //tg on

						while((zcnn->fx.ctrl & 2)!=0){
							//poling wait
						}
						zcnn->fx.mif |= 2; //write on
						while((zcnn->fx.ctrl & 2)!=0){
							//poling wait
						}
						p2 = 0; //clear
					}
				}
			}
		}
	}


	intconv_data_copy_from_fpga(planes.data,
								last_pointer*4,                  //copy address
								img_size.width * img_size.height //copy size
	);

	fpga_close();

}

int main(int argc, char* argv[]){
    double t = 0;
    t = (double)cvGetTickCount();

	cnn_param_t lx;
	cnn_param_t *lp = &lx;
	FILE *pp,*bp,*wp;
	int i,j,k,l;


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
	fscanf(pp,"%d",&lp->step_loop);

	int total_output_planes = 0;
	int total_filter_loop = 0;
	lp->max_input_planes = 0;

	for(i=0;i<lp->step_loop;i++){
		fscanf(pp,"%d %d",
			   &lp->input_loop[i],
			   &lp->output_loop[i]);
		if (lp->max_input_planes<lp->input_loop[i]){
			lp->max_input_planes = lp->input_loop[i];
		}
		total_output_planes += lp->output_loop[i];
		total_filter_loop +=  lp->input_loop[i] * lp->output_loop[i];
	}
	fclose(pp);

	lp->bias_p = (uint32_t*)malloc(sizeof(uint32_t)*(total_output_planes+1));
	lp->weights_p = (uint32_t*)malloc(sizeof(uint32_t)*(total_filter_loop*9+1));

	fread(lp->bias_p,sizeof(uint32_t),total_output_planes,bp);
	fread(lp->weights_p,sizeof(uint32_t),total_filter_loop*9,wp);

	fclose(bp);
	fclose(wp);


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

	int overrun = lp->step_loop;

	//divide plane
	int div;
	int div_height;
	int cache_size = (320*320);
	div_height = cache_size / img2_size.width - overrun*2;

	if (div_height>=img2_size.height){ //cacheにおさまる
		convert_fpga(color_planes[0],lp);
	}else{
		if (div_height<=(overrun*2+1)){
			//Error
			printf("div error %d\n",div_height);
			return 0;
		}else{
			int y,n;
			printf("***DIV HEIGHT %d\n",div_height);
			std::vector<cv::Mat>  div_color_planes;
			std::vector<cv::Mat>  conv_color_planes;
			std::vector<cv::Size> div_size;
			cv::Size temp_size;
			cv::Mat temp_img;
			cv::Mat temp_img2;
			//分割イメージの作成
			for(i=img2_size.height,y=0,n=0;i>0;n++){
				if (y==0){
					cv::Rect rect(0,0,img2_size.width,div_height+overrun); // x,y,w,h
					temp_img = color_planes[0](rect);
					div_size.push_back(cv::Size(img2_size.width,div_height));
				}else{
					if (i>div_height){
						cv::Rect rect(0,y-overrun,img2_size.width,div_height+overrun); // x,y,w,h
						temp_img = color_planes[0](rect);
						div_size.push_back(cv::Size(img2_size.width,div_height));
					}else{
						cv::Rect rect(0,y-overrun,img2_size.width,i+overrun); // x,y,w,h
						temp_img = color_planes[0](rect);
						div_size.push_back(cv::Size(img2_size.width,i));
					}
				}
				div_color_planes.push_back(temp_img.clone());
				y+=div_height;
				i-=div_height;
			}

			for(i=0;i<n;i++){
				convert_fpga(div_color_planes[i],lp);
				if (i==0){
					conv_color_planes.push_back( div_color_planes[i](cv::Rect(0,0,img2_size.width,div_size[i].height)));
				}else{
					conv_color_planes.push_back( div_color_planes[i](cv::Rect(0,overrun,img2_size.width,div_size[i].height)));
				}
			}

			std::vector<cv::Mat>::iterator it = conv_color_planes.begin(), it_end = conv_color_planes.end();
			cv::Rect roi_rect;
			for (; it != it_end; ++it) {
				roi_rect.width = it->cols;
				roi_rect.height = it->rows;
				cv::Mat roi(color_planes[0], roi_rect);
				it->copyTo(roi);
				roi_rect.y += it->rows;
			}
		}
	}

	//
	cv::Mat img_dst;
	cv::merge(color_planes, img_dst);

	cv::Mat img_out;
	//to RGB
	cv::cvtColor(img_dst,img_out,CV_YCrCb2BGR);

	//preview
    cv::imshow( "result", img_out );

    t = (double)cvGetTickCount() - t;
    printf( "time = %g ms\n", t/((double)cvGetTickFrequency()*1000.) );

	cv::waitKey(0);

	free(lp->bias_p);
	free(lp->weights_p);

	return 0;
}
