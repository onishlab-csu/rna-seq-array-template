#!/usr/bin/env bash
#SBATCH --job-name=merge-featurecounts
#SBATCH --nodes=1                           # this script is designed to run on one node
#SBATCH --ntasks=1                          # modify this number to reflect how many cores you want to use (up to 24)
#SBATCH --time=04:00:00                     # modify this number to reflect how much time to request
#SBATCH --partition=amilan                  # modify this to reflect which queue you want to use. 
#SBATCH --mail-type=END                     # Keep these two lines of code if you want an e-mail sent to you when it is complete.
#SBATCH --mail-user=$USER                   # add your e-mail here
#SBATCH --output=log_merge-featurecounts_%j.txt     # this will capture all output in a logfile with %j as the job #
source project-settings.bashrc
outputdir=$1 # such as ../03_output/2022-12-03_output
RScript $outputdir/*counts.txt # writes all.counts


