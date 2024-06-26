#!/usr/bin/env bash
################################################
# PROGRAM:
# RNAseq_analyzer_single.sh
#
# DESCRIPTION:
# Erin O.Nish. - This is a very basic RNA-seq pipeline that I use for analyzing fastq reads. Step1 is a
# simple wrapper that performs quality control, genome alignment, basic format
# conversions, and htseq-count tabulation for paired-end RNA-seq samples using a specified
# genome. Step2 is a clean up program that removes unnecessary files and compresses files
# to save space.
# 
# David C.King - I have modified this to run on a single sample set, parsed from the metadata file,
# and specified via the wrapper script which is run with the sbatch --array option.

#
# AUTHOR:
# <yournamehere>
#
# START DATE:
# November 29, 2023
#
# DEPENDENCIES:
# 	Requires the installation of the follwing software: 
#		fastp
#		hisat2
#		featureCounts (subread)
#		samtools
#		bedtools
#		deep-tools
#
# CONDA environment reflects CURC Alpine HPC in November of 2023:
#       conda create --name 2023dsci -c bioconda fastp bwa hisat2 bedtools samtools subread deeptools
#
#    If there are problems with the above, you may try to create the environment directly 
#    using the yaml file provided in the current directory (02_SCRIPTS):
#       conda env create -f 2023dsci_environment.yml
# 

# DO NOT EDIT: this figures out directory settings and loads conda environment
THIS_SCRIPT_DIR=$(readlink -f $(dirname $BASH_SOURCE))
source ${THIS_SCRIPT_DIR}/../project-settings.bashrc

# REQUIRES:
#    INPUT: .fastq files.    For each sample, paired forward and reverse sequencing files
#								are required. These should be placed in an input
#								directory.
#
#    INPUT: _metadata.txt file: A metadata file with two columns. The first two columns
#								are fastq file names. The third column is a "nickname"
#								of each sample. Later columns can be included with other
#								metadata information. Metadata file should be placed
#								within the inputdir directory.
#
#
#    HISAT2 INDEXES: .ht2 files for the genome. These are produced using hisat2-build. For
#								instructions see
#	           https://ccb.jhu.edu/software/hisat2/manual.shtml#the-hisat2-build-indexer
#
#    GENOME SEQUENCE: .fa  or .tar.gz file for the genome. This is the sequence of the 
#                                genome.
#
#    GENOME ANNOTATION: .gtf file for the genome. This is a genome annotation file of gene
#								features. Version and coordinates must match the genome
#								sequence (.fa above).
#
# USAGE:
# $ bash RNAseq_analyzer_single.sh sample1 sample2 samplename <number of threads>
#
# OUTPUT:
#
# KNOWN BUGS:
#
# THINGS TO IMPROVE:
#
################################################

#Metadata file. This pulls the metadata path and file from the command line
metadata=$1


####### LOAD SETTINGS: modify if desired  #############
echo "Using the following settings:"
echo "ROOT=$PROJ_ROOT"
echo "HISAT2PATH=$HISAT2PATH"
echo "HISAT2PREFIX=$HISAT2PREFIX"
echo "INPUTDIR=$INPUTDIR"
echo "GTFFILE=$GTFFILE"
echo "GENOMEFA=$GENOMEFA"
echo "OUTPUTROOT=$OUTPUTROOT"

#This is the output_directory:
DATE=`date +%Y-%m-%d`
outputdir="${OUTPUTROOT}/"$DATE"_output/"
echo "outputdir=$outputdir"
echo "Executing tools installed in: $CONDA_PREFIX"
exit 0

########## DONE MODIFYING ###############


########## BEGIN CODE ###############

echo -e ">>> INITIATING analyzer with command:\n\t$0 $@"

#Number of threads to use:
# Note - this imports the number of threads (ntasks) given in the command line
pthread=$4

# Make output directories
echo -e ">>> MAKING output directory"
echo -e "\tmkdir $outputdir"
mkdir -p $outputdir



####### META DATA #############

#These are the sample names, R1:
sample1=$1

#These are the sample names, R2:
sample2=$2

#These are the nicknames I want to give the files:
samplename=$3



####### PIPELINE ##############

# Report back to the user which files will be processed and which names they'll be given:
echo -e ">>> INPUT: This script will process files from the metafile:\n\t$metadata"
echo -e ">>> PLAN: This script will process the sample files into the following names: "
echo -e "\tSAMPLE1\tSAMPLE2\tNAMES"

echo -e "\t${samples1}\t${samples2}\t${names}"


# FASTP to remove unwanted sequences
# FASTP to determine quality
echo -e "\n>>> FASTP: Trimming excess and low-quality sequences from .fastq file; generating quality report"
mkdir -p $outputdir"01_fastp"

# This loop is now unnecessary. 
# Each invocation of this script handles a different line of the metadata file, 
# controlled by giving a numeric range in the launcher script like so:
#  sbatch --array=1-5 execute_RNAseq_pipeline.sbatch
# ... if you have 5 samples, each with its own line in the metadata file.
#for (( counter=0; counter < ${#samples1[@]}; counter++ ))
#do
    #samplename=${names[$counter]}
    #sample1=${samples1[$counter]}
    #sample2=${samples2[$counter]}

## Echo statements

        ##### ENTER ECHO STATEMENTS HERE #####

## Make output directories
mkdir -p $outputdir"01_fastp/"$samplename

## execute fastp
cmd1="fastp -i $inputdir/$sample1 \
-I $inputdir/$sample2 \
-o ${outputdir}01_fastp/${samplename}/${samplename}_trim_1.fastq \
-O ${outputdir}01_fastp/${samplename}/${samplename}_trim_2.fastq \
-h ${outputdir}01_fastp/${samplename}/${samplename}_report.html \
-j ${outputdir}01_fastp/${samplename}/${samplename}_report.json \
--detect_adapter_for_pe \
--thread $pthread \
-x -g "

echo -e "\t$ ${cmd1}"
time eval $cmd1

#done

# HISAT2 to align to the genome
echo -e "\n>>> HISAT2: aligning each sample to the genome"
outhisat2=$outputdir"02_hisat2/"
mkdir -p $outhisat2

# Convert loop to single invocation - see note above
#for (( counter=0; counter < ${#samples1[@]}; counter++ ))
#do

## execute hisat2
cmd3="hisat2 -x $hisat2prefix -1 $outputdir"01_fastp/"$samplename/$samplename"_trim_1.fastq" -2 $outputdir"01_fastp/"$samplename/$samplename"_trim_2.fastq" -S ${outhisat2}${samplename}.sam --summary-file ${outhisat2}${samplename}_summary.txt --no-unal -p $pthread"
echo -e "\t$ $cmd3"
time eval $cmd3

#done



# FEATURECOUNTS to tabulate reads per gene:
echo -e "\n>>> FEATURECOUNTS: Run featureCounts on all files to tabulate read counts per gene"
outfeature=$outputdir"03_feature/"
mkdir -p $outfeature

# Acquire a list of .sam names
samfile=${name}.sam
samfilePath=${outhisat2}${samfile}

# Execute featureCounts
cmd4="featureCounts -p -T $pthread -a $gtffile -o ${outfeature}counts.txt ${samfilePath}"
echo -e "\t$ $cmd4"
time eval $cmd4

# SAMTOOLS and BAMCOVERAGE: to convert .sam output to uploadable .bam and .wg files
echo -e "\n>>> SAMTOOLS/BAMCOVERAGE: to convert files to uploadable _sort.bam and _sort.bam.bai files:"
samout=$outputdir"04_samtools/"
mkdir -p $samout

#for seqname in ${names[@]}
#do

# echo
echo -e "\tSamtools and BamCoverage convert: ${seqname}"

# Samtools: compress .sam -> .bam
cmd5="samtools view --threads $pthread -bS ${outhisat2}${seqname}.sam > ${samout}${seqname}.bam"
echo -e "\t$ ${cmd5}"
time eval $cmd5


# Samtools: sort .bam -> _sort.bam
cmd6="samtools sort --threads $pthread -o ${samout}${seqname}_sort.bam --reference $genomefa ${samout}${seqname}.bam"
echo -e "\t$ ${cmd6}"
time eval $cmd6


# Samtools: index _sort.bam -> _sort.bam.bai
cmd7="samtools index ${samout}${seqname}_sort.bam"
echo -e "\t$ ${cmd7}"
time eval $cmd7


# bamCoverage: Create a .bw file that is normalized. This can be uploaded to IGV or UCSC
cmd8="bamCoverage -b ${samout}${seqname}_sort.bam -o ${samout}${seqname}_sort.bw --outFileFormat bigwig -p $pthread --normalizeUsing CPM --binSize 1"
echo -e "\t$ ${cmd8}"
time eval $cmd8
    
#done




######## VERSIONS #############
echo -e "\n>>> VERSIONS:"
echo -e "\n>>> FASTP VERSION:"
fastp --version
echo -e "\n>>> HISAT2 VERSION:"
hisat2 --version
echo -e "\n>>> SAMTOOLS VERSION:"
samtools --version
echo -e "\n>>> FEATURECOUNTS VERSION:"
featureCounts -v
echo -e "\n>>> BAMCOVERAGE VERSION:"
bamCoverage --version
echo -e ">>> END: Analayzer complete."
