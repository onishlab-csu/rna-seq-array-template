#!/usr/bin/env bash
# See https://curc.readthedocs.io/en/latest/running-jobs/job-resources.html for more options
#SBATCH --job-name=execute_hisat2-build
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --partition=atesting # change to amilan when the script is working
#SBATCH --time=0:29:00   # modify this to reflect how long to let the job go. This indicates 4 hours.
#SBATCH --output=log_hisat2-build_%J.txt

# ------------------------------------------------------
# set temporary directories
export TMPDIR=$SLURM_SCRATCH
export TMP=$TMPDIR
# ------------------------------------------------------
# conda environment
module load anaconda/2022.10
conda activate YOUR_ENVIRONMENT_NAME # contains hisat2 utilities
# ------------------------------------------------------
 
# Build hisat2 indexes for downloaded genome
hisat2-build -p ${SLURM_NTASKS} chrI.fa,chrII.fa,chrIII.fa,chrIV.fa,chrM.fa,chrV.fa,chrX.fa ce11
 
# Check the build
echo -e "\n\nINDEX-BUILD: inspecting indexes:"
hisat2-inspect -s ce11
 
# Capture version number
echo -e "\n\nINDEX-BUILD: version:"
hisat2-build --version

