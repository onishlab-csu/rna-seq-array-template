## Hisat2 index setup

In this directory, you 
* download and verify the chromosome sequences, and
* build the hisat2 index files. 

### Download script 

This doesn't normally need to be done in a batch job if the files are of modest size (as in *C. elegans* chromosomes).

```
bash download-celegans-chromosomes.sh
```

This script also checks the md5 sums. Successful completion looks like below:

```
--2024-02-06 21:42:27--  https://hgdownload.soe.ucsc.edu/goldenPath/ce11/chromosomes/chrX.fa.gz
Resolving hgdownload.soe.ucsc.edu (hgdownload.soe.ucsc.edu)... 128.114.198.53
Connecting to hgdownload.soe.ucsc.edu (hgdownload.soe.ucsc.edu)|128.114.198.53|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 5666803 (5.4M) [application/x-gzip]
chrX.fa.gz                           100%[====================================================================>]   5.40M  17.0MB/s    in 0.3s    
chrI.fa.gz: OK
chrII.fa.gz: OK
chrIII.fa.gz: OK
chrIV.fa.gz: OK
chrM.fa.gz: OK
chrV.fa.gz: OK
chrX.fa.gz: OK
```

A line like `chrI.fa.gz: OK` denotes a valid checksum.

### Ungzip and concatenate fasta files to a single genome sequence file

```
gunzip *.fa.gz
cat *.fa > ce11_wholegenome.fa
```

## Build hisat2 indexes

Submit job:

```
sbatch hisat2-build.sbatch
```

## Download gene models

[GTF vs GFF3](https://www.ncbi.nlm.nih.gov/genbank/genomes_gff/)



There are different choices for the gene annotations from UCSC:

- [ce11.ensGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/ce11/bigZips/genes/ce11.ensGene.gtf.gz) 
- [ce11.ncbiRefSeq.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/ce11/bigZips/genes/ce11.ncbiRefSeq.gtf.gz) 
- [ce11.refGene.gtf.gz](https://hgdownload.soe.ucsc.edu/goldenPath/ce11/bigZips/genes/ce11.refGene.gtf.gz) 
