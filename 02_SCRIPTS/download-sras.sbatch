#!/usr/bin/env bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --time=02:00:00
#SBATCH --partition=amilan
#SBATCH --output=log-download-%j.out
 
# EXECUTE code with: $ sbatch --array=1-18 download-sras.sbatch <file_listing_SRR_files.txt>
# There are 18 accessions in ../SRR_Acc_List_GomezOrte.txt, therefore use --array=1-18 as 1st arg to sbatch
 
# INSTALL software
module purge
module load sra-toolkit
 
# RUN SCRIPT
i=1 
while read line
do
    if [ $i -eq ${SLURM_ARRAY_TASK_ID:=1} ]
    then
        echo -e $line
        echo "fasterq-dump -e $SLURM_NTASKS --split-files $line"
        time fasterq-dump -e $SLURM_NTASKS --split-files $line
        echo "vdb-validate $line"
        vdb-validate $line
    else
        i=$((i+1))
    fi
done < $1

