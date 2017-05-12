#!/bin/bash
#$ -l mem=10G,time=18:: -S /bin/bash -N extract.sh -j y -cwd
BAMTOOLS="/ifs/scratch/c2b2/ip_lab/jw3354/bamtools/bin/bamtools"
ls
touch checksumrpt.txt
touch baicks
md5sum *.bai >baicks 
touch bamcks 
md5sum *.bam > bamcks
diff bamcks checksum/*.bam.md5 >> checksumrpt.txt
diff baicks checksum/*.bai.md5  >> checksumrpt.txt
if [ -s checksumrpt.txt ];then 
    touch error.txt
    echo "check sum fail" >> error.txt
    exit 1 
fi
echo "split"
mkdir split
cd split
ln ../*.bam .
$BAMTOOLS split -in *.bam -reference
cp *22.bam ..
cd ..
rm -r split
exit 1
