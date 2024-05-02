# this is the conda environment name
ENVIRONMENT_NAME=2023dsci

# this activates conda in your script
module load anaconda/2022.10 # if you are on Alpine
source $(dirname $CONDA_EXE)/../etc/profile.d/conda.sh # use this if you are not using BASH as your main shell (e.g. zsh on mac)
conda activate $ENVIRONMENT_NAME


# put your project's full path here or leave blank to use the current directory
PROJECT_FULL_PATH=

SCRIPT_DIR=$(readlink -f $(dirname $BASH_SOURCE)) # determine the directory of this current file
PROJ_ROOT=${PROJECT_FULL_PATH:=$SCRIPT_DIR}


#The input samples live in directory:
INPUTDIR="${PROJ_ROOT}/01_INPUT"

#This is where the ht2 files live:
HISAT2PATH="${INPUTDIR}/ce11IndexBuild"
HISAT2PREFIX="${HISAT2PATH}/ce11" # this is the file prefix for the indices. Eg: ce11.1.ht2  ce11.2.ht2, etc.

#This is where the gtf file lives:
GTFFILE="${HISAT2PATH}/Escherichia_coli_gca_001606525.ASM160652v1_.57.gff3"

#This is where the genome sequence lives:
GENOMEFA="${HISAT2PATH}/ce11_wholegenome.fa"

# The script will create a subdirectory under the following with the date incorporated
OUTPUTROOT="${PROJ_ROOT}/03_OUTPUT"

