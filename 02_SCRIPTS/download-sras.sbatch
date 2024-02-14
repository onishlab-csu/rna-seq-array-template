#!/usr/bin/env bash
 
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --time=02:00:00
#SBATCH --partition=amilan
#SBATCH --output=log-download-%j.out
 
# EXCUTE code with: $ sbatch automateSRA.sbatch <file_listing_SRR_files.txt>
 
# INSTALL software
module purge
module load sra-toolkit
 
# RUN SCRIPT
i=0 
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
        i=$((i++))
    fi
done < $1