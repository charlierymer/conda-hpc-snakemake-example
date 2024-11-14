#!/bin/bash

##################### edited to run using an array job ################

#SBATCH --job-name=test_job
#SBATCH --partition=teach_cpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0:10:00
#SBATCH --mem=100M
#SBATCH --account=SSCM033324
#SBATCH --output ./slurm_logs/%j.out

# the array task IDs are now 2,3,4,5
#SBATCH --array=2-5


cd "${SLURM_SUBMIT_DIR}"

echo 'Setting up environment'

source ~/initConda.sh

mamba activate ahds_week9

mkdir -p ./slurm_logs/
mkdir -p ../../results
mkdir -p ../../data/derived/intermediate

cd ../

Rscript 0_get_conditions.R

echo 'Starting analysis'


tr ',' '\n' < ../data/derived/top_conditions.csv

INFILE=$(sed -n "${SLURM_ARRAY_TASK_ID}p" ../data/derived/top_conditions.csv)

Rscript 1_find_side_effects.R $INFILE
Rscript 2_plot_wordcloud.R $INFILE



# pull out the required condition from the conditions.csv
# condition=$(head -n ${SLURM_ARRAY_TASK_ID} ../data/derived/top_conditions.csv)

# run each Rscript using this value
#Rscript 1_find_side_effects.R "${condition}"
#Rscript 2_plot_wordcloud.R "${condition}"

#{       read
#        while IFS=, read -r line;
#        do
#
#                Rscript 1_find_side_effects.R "${line}"
#                Rscript 2_plot_wordcloud.R "${line}"
#        done
#
#}< ../data/derived/top_conditions.csv

