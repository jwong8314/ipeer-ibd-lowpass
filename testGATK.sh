#!/bin/bash
#$ -l mem=12G,time=1:: -S /bin/bash -N testing.sh -j y -cwd
GATK=/ifs/scratch/c2b2/ip_lab/jw3354/GATK/GenomeAnalysisTK.jar
FASTA=/ifs/scratch/c2b2/ip_lab/jw3354/fasta/human_g1k_v37.fasta
PICARD=/ifs/scratch/c2b2/ip_lab/jw3354/fasta/picard.jar
NAME=$1
BCFTOOLS=/ifs/scratch/c2b2/ip_lab/jw3354/bcftools/bin/bcftools
echo "start"
module load java
#module load samtools
#
#java -Xmx2048m -jar $PICARD SortSam \
#VALIDATION_STRINGENCY=LENIENT \
#INPUT=$NAME.bam \
#OUTPUT=$NAME.sorted.bam \
#SORT_ORDER=coordinate \
#CREATE_INDEX=true
#echo "DONE formating"
#
#java -Xmx2048m -jar $GATK \
# -T HaplotypeCaller \
# -R $FASTA \
# -I $NAME.sorted.bam \
# -L 22 \
# -dfrac 0.1 \
# -o $NAME-0.1.vcf
#
#echo "0.1"
#java -Xmx2048m -jar $GATK \
# -T HaplotypeCaller \
# -R $FASTA \
# -I $NAME.sorted.bam \
# -L 22 \
# -o $NAME-1.0.vcf
#echo "1.0"
gzip *.vcf
$BCFTOOLS view -m2 -M2 -v snps -o $NAME-1.0.drop-multi.vcf.gz $NAME-1.0.vcf.gz

$BCFTOOLS view -m2 -M2 -v snps -o $NAME-0.1.drop-multi.vcf.gz $NAME-0.1.vcf.gz
