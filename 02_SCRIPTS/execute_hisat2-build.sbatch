#!/usr/bin/env bash
 
#SBATCH --job-name=execute_hisat2-build
#SBATCH --nodes=1
#SBATCH --ntasks=4 # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --partition=atesting # change to amilan when the script is working
#SBATCH --time=0:29:00   # modify this to reflect how long to let the job go. This indicates 4 hours.
#SBATCH --output=log_hisat2-build_%J.txt
 
 
# Build hisat2 indexes for C. elegans
 
 
# Check the build
 
 
# Capture version number