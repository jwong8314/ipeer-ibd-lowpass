#include <stdio.h>
#include <stdlib.h>
int main(int argc, char **argv){
  if (argc == 1){
    printf ("Usage: downsample <dir of sam>\n");
		exit(1);
	}
  FILE *fp = fopen(argv[1], "r");
  char buffer[1024];
	int count = 0;
	while (fgets(buffer, 1024, fp) !=NULL){
    count++;
	}
	if (ferror(fp)) printf("Read Error\n");
	else printf("Lines: %d\n", count);
	fclose(fp);
}




