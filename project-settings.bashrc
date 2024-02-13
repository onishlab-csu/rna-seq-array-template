PROJ_ROOT=$(readlink -f $(dirname $BASH_SOURCE)) # determine the directory of this current file

# this is the conda environment name
ENVIRONMENT_NAME=2023dsci

# put your project's full path here:

#The input samples live in directory:
INPUTDIR="${PROJ_ROOT}/01_INPUT"

#This is where the ht2 files live:
HISAT2PATH="${PROJ_ROOT}/ce11IndexBuild"
HISAT2PREFIX="${HISAT2PATH}/ce11" # this is the file prefix for the indices. Eg: ce11.1.ht2  ce11.2.ht2, etc.

#This is where the gtf file lives:
GTFFILE="${HISAT2PATH}/Escherichia_coli_gca_001606525.ASM160652v1_.57.gff3"

#This is where the genome sequence lives:
GENOMEFA="${HISAT2PATH}/Escherichia_coli_gca_001606525.ASM160652v1_.dna.toplevel.fa"

# The script will create a subdirectory under the following with the date incorporated
OUTPUTROOT="${PROJ_ROOT}/03_output"

