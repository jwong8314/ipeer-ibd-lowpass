#!/bin/bash
#$ -l mem=48G,time=12:: -S /bin/bash -N testing.sh -j y -cwd

HOME=/ifs/scratch/c2b2/ip_lab/jw3354
TABIX=$HOME/bcftools/bin/tabix
BCFTOOLS=$HOME/bcftools/bin/bcftools
EAGLE=$HOME/eagle/Eagle_v2.3.2/eagle
BEAGLE=$HOME/Beagle/beagle.21Jan17.6cc.jar
MAP=$HOME/eagle/Eagle_v2.3.2/tables/genetic_map_hg19_withX.txt
FILE=TAGC_illumina
CHROM=1
CPU=$(nproc)

# $TABIX -p vcf ${FILE}.vcf.gz || echo "index failed"; 
echo "done index"

# $TABIX -h ${FILE}.vcf.gz "${CHROM}" > ${FILE}.chr${CHROM}.vcf \
# || {echo "extraction failed" exit 1}
echo "extract chr${CHROM}"
# $BCFTOOLS view -m2 -M2 -v snps -o ${FILE}.chr${CHROM}.drop-multi.vcf.gz ${FILE}.chr${CHROM}.vcf \
# || {echo "drop multiallelic failed" exit 1}
echo "done dropping multiallelic"

$EAGLE \
--numThreads $CPU \
--vcf ./${FILE}.chr${CHROM}.drop-multi.vcf.gz \
--geneticMapFile ${MAP} --outPrefix ${FILE}.phased-only${CHROM} \
--chrom ${CHROM} \
 || {echo "eagle failed to phase" exit 1}
echo "done phasing with eagle"
module load java
java -Xss5m -Xmx4g -jar $BEAGLE \
nthreads=$CPU \
ibd=true \
ibdcm=1.0 \
gt=${FILE}.phased-only${CHROM}.vcf.gz \
out=${FILE}.beagle.chr${CHROM} \
 || {echo "beagle failed to call ibd" exit 1}
echo "done beagle ibd call"
