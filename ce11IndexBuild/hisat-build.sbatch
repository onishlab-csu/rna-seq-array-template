#!/usr/bin/env bash
 
#SBATCH --job-name=hisat2-build
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --time=00:29:00
#SBATCH --partition=amilan
#SBATCH --output=log_hisat2-build_%j.txt

# ------------------------------------------------------
# load settings
source ../project-settings.bashrc
# defines: conda ENVIRONMENT_NAME 
# ------------------------------------------------------

# ------------------------------------------------------
# set temporary directories
export TMPDIR=$SLURM_SCRATCH
export TMP=$TMPDIR
# ------------------------------------------------------
# conda environment
module load anaconda/2022.10
conda activate $ENVIRONMENT_NAME # contains hisat2 utilities
# ------------------------------------------------------
 
# Build hisat2 indexes for C. elegans
hisat2-build -p ${SLURM_NTASKS} ce11_wholegenome.fa ce11
 
 
# Check the build
echo -e "\n\nINDEX-BUILD: inspecting indexes:"
hisat2-inspect -s ce11
 
# Capture version number
echo -e "\n\nINDEX-BUILD: version:"
hisat2-build --version
