#!/usr/bin/env bash

#SBATCH --job-name=RNAseq_pipeline 
#SBATCH --nodes=1                           # this script is designed to run on one node
#SBATCH --ntasks=2                          # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=04:00:00                     # modify this number to reflect how much time to request
#SBATCH --partition=amilan                    # modify this to reflect which queue you want to use. Either 'shas' or 'shas-testing'
#SBATCH --qos=normal                        # Should be 'normal' if partition is 'shas'; should be 'testing' if partition is 'shas-testing'
#SBATCH --mail-type=END                     # Keep these two lines of code if you want an e-mail sent to you when it is complete.
#SBATCH --mail-user=<youremail>             # add your e-mail here
#SBATCH --job-name=RNAseq-execute
#SBATCH --output=%x.%A_%a.log     # this will capture all output in a logfile with %j as the job #

######### Instructions ###########

# Modify your SLURM entries above to fit your choices
# Below, modify the SECOND argument to point to YOUR metadata.file
# Below, you don't need to change $SLURM_NTASKS. It will automatically populate whatever you put in --ntasks=# above.
# Execute this script using (for n lines in your metadata file) $ sbatch --array=1-n execute_RNAseq_pipeline.sbatch

# See https://gist.github.com/meekrob/97be47bff67726702d6d4ba5dd00dd29 for a general array job script template

## Execute the RNA-seq_pipeline to run the pipeline
## make sure your metadatafile has line numbers as first column
## example:
#1  tester_SRR5832182_1.fastq	tester_SRR5832182_2.fastq	EG01	01_Ecoli_15_1	Ecoli	15	1
#2  tester_SRR5832183_1.fastq	tester_SRR5832183_2.fastq	EG02	01_Ecoli_15_1	Ecoli	15	2

METADATAFILENAME="metadata.txt"
WHICH_LINE_FROM_METADATA=${SLURM_ARRAY_TASK_ID:=1}
ARGS=( $(grep -w $WHICH_LINE_FROM_METADATA $METADATAFILENAME) )
sample1=${ARGS[1]}
sample2=${ARGS[2]}
samplename=${ARGS[3]}

cmd="bash RNAseq_analyzer_single.sh $sample1 $sample2 $samplename $SLURM_NTASKS"
echo $cmd
time eval $cmd
