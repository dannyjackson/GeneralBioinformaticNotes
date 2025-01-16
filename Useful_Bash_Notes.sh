### Useful Bash Notes

## code for canceling a slurm array
for job in {JOBID1..JOBID20}; do
    scancel $job
done

## Slurm Header

#!/bin/bash

#SBATCH --job-name=XXX
#SBATCH --ntasks=12
#SBATCH --nodes=1             
#SBATCH --time=240:00:00   
#SBATCH --partition=standard
#SBATCH --account=mcnew
#SBATCH --mem-per-cpu=1000gb
#SBATCH --mail-type=ALL
#SBATCH --mail-user=dannyjackson@arizona.edu
#SBATCH --output=output.XXX.%j

## Running parallel jobs within one slurm script
echo "Job started on `date`"
echo "Aligning fastas"

# apply ${C} wherever a samplename belongs in the script
parallel -j 12 -a /path/to/samplenames.txt 'C={}; example command -t 12 ${C}_file.fq.gz' 


## Using awk to compute average and standard deviation from samtools depth output
awk '{sum+=$3; sumsq+=$3*$3} END { print "Average = ",sum/NR; print "Stdev = ",sqrt(sumsq/NR - (sum/NR)**2)}' file.depthstats >> depthstats.txt
