# RNA-seq array template

## Requirements
* conda to install from environment, otherwise the following tools:
*
  - deeptools
  - fastp
  - subread
  - hisat2
  - samtools
  - bedtools
  - bwa

### Installation using conda:

1.) Create the environment from an environment file.

#### On CURC Alpine:
`conda env create -f 2023dsci_environment.yml`
#### Elsewhere:
`conda env create -f 2023dsci_environment_from_history.yml`

2.) The script loads conda from a module, find the line `conda activate 2023dsci` in RNAseq_analyzer_single.sh. The previous line loads a module on Alpine and may be different/unnecessary on your system.


## Main Changes from source script
* The main analyzer script has been modified to run on Alpine. I renamed it to **single** because it only runs one sample set.
* The execute script *greps* the information from the metadata file and passes the argument set to the analyzer. It uses SLURM_ARRAY_TASK_ID to 
determine which line to parse.
* Since the feature counts step is run one-at-a-time, the output files must be aggregated.

## To do
* Test on *C. elegans* example data from class. I tested it on Gomez *E. coli* data but nothing aligned.
* Test the feature counts aggregation. Since there were no *E. coli* alignments, I haven't tried it yet.

