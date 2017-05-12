Justin Wong
Itsik Pe'er Lab

GOAL: To check robustness of pipeline on a downsampled low coverage data set
DATA: from TAGC dataset, contains BAM files for roughly 15 samples
 -- have a vcf for whole TAGC
 -- have bamfiles for 15 samples: in scratch/*/data
    NOTE: have already extracted 22nd chromosome

SCRIPTS: 
extract.sh -- splits off 22nd chromosome
master.sh -- takes a bgzip file and runs finds IBD segments 
  - generate .tbi
	- extracts a chromosome
	- drop multiallelic
	- call eagle to phase
	- call beagle to call ibd
bcftools.sh -- drops multiallelic sites
testGATK.sh -- runs HaplotypeCaller on sorted bam
  - sorts 
	- call HaplotypeCaller both 1.0 and 0.1 sampling
	- removes multiallelic

NOTE: multialleic sites were dropped as that they usually imply poor read
quality.
