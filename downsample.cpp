#include <time.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main(int argc, char **argv){
  if (argc < 4){
    printf ("Usage: downsample <path of sam> <path of output> <coverage>\n");
		exit(1);
	}
	srand(time(NULL));
  long chr22bp = 50818468;	
  FILE *fp = fopen(argv[1], "r");
	int coverage = atoi(argv[3]);
  char buffer[1024];
	int count = 0;
	char *seq;
	int bases = 0;
	/* counts number of bases and reads */
	while (fgets(buffer, 1024, fp) !=NULL){
    if (buffer[0] != '@'){
				strtok(buffer, "\t");
        for (int i = 0; i <8;i++)  
						strtok(NULL, "\t");
        seq = strtok(NULL, "\t"); 
				count++; bases += strlen(seq);
		}
	}
	if (ferror(fp)) printf("Read Error\n");
	else printf("Lines: %d\n", count);
	rewind(fp);
  if (chr22bp*coverage > bases) {
		printf("no need to downsample\n");
		exit(1);
	}
	int avg = bases/count;
	int ifrac = bases/(chr22bp*coverage); 
  //Fails if input same as output
  FILE *outp = fopen(argv[2], "w");
	while (fgets(buffer, 1024, fp) != NULL){
		if (buffer[0] != '@'){
		  
		  if(rand() % ifrac == 0) 
				fwrite(buffer,strlen(buffer),1,outp);
			
		}
		else{
      fwrite(buffer, strlen(buffer), 1, outp);
		}
	}
	fclose(outp);
	fclose(fp);

}




