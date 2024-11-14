#!/bin/bash

# making a derived directory
mkdir -p ../../data/derived

# running the setup script
# source ../setup/installConda.sh


# get the top_conditions:
Rscript ../0_get_conditions.R

echo "CONDITIONS:" > ../config.yml
{       read
        while IFS=, read -r line;
        do
                printf "  - ${line}\n">>../config.yml

        done

} < ../../data/derived/top_conditions.csv

