# RNA-seq array template

## Main Changes
* The main analyzer script has been modified to run on Alpine. I renamed it to **single** because it only runs one sample set.
* The execute script *greps* the information from the metadata file and passes the argument set to the analyzer. It uses SLURM_ARRAY_TASK_ID to 
determine which line to parse.
* Since the feature counts step is run one-at-a-time, the output files must be aggregated.

## To do
* Test on *C. elegans* example data from class. I tested it on Gomez *E. coli* data but nothing aligned.
* Test the feature counts aggregation. Since there were no *E. coli* alignments, I haven't tried it yet.

