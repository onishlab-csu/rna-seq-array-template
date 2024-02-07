## Setup

Here you download and verify the chromosome sequences. This doesn't normally need to be done in a batch job.

### Download script execution

```
bash download-chromosomes.sh
```

Successful completion looks like below:

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

The lines like `chrI.fa.gz: OK` are verifying the md5sums.