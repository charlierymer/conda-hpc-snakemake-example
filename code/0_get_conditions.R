#load packages
library(tidyverse)

#read in data

# changing the relative file path to an absolute one:
# dta <- read_tsv('../data/original/drugLibTrain_raw.tsv')
dta <- read_tsv('~/week_9/conda-hpc-snakemake-example/data/original/drugLibTrain_raw.tsv')

#10 most common conditions

dta %>% 
  count(condition, sort=TRUE) %>%
  head(4) %>%
  select(condition) %>%
  write_csv('~/week_9/conda-hpc-snakemake-example/data/derived/top_conditions.csv')
