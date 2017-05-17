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
	- remove low frequency SNPs with filter.py 
	- call beagle to call ibd
downsample.cpp -- program downsamples a given sam file
  - NOTE: original file accidentially deleted so was rewritten
	        thus this version may not be completely debugged 
					and never used on real SAM
  - count number of bases
	- uniformly sample the reads by proper fraction to obtain desired coverage
testGATK.sh -- runs HaplotypeCaller on sorted bam
  - sorts 
	- call HaplotypeCaller both 1.0 and 0.1 sampling
	- removes multiallelic
filter.py
  - written by Ryan Bernstein
	- takes vcf.gz and drops low frequency SNPs
	- outputs to STDOUT a vcf

NOTE: multialleic sites were dropped as that they usually imply poor read
quality.
