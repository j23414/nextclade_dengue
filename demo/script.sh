#! /usr/bin/env bash

set -euv

# 1. Download samples
export INPUT_TAR=gisaid_auspice_input_hcov-19_2023_06_27_18.tar

# list files in tar
tar -tvf $INPUT_TAR
#>   304294 Jun 27 11:37 /1687891060186.metadata.tsv
#> 11826195 Jun 27 11:37 /1687891060186.sequences.fasta


# extract
tar -xvf $INPUT_TAR

export INPUT_METADATA=1687891060186.metadata.tsv
export INPUT_FASTA=1687891060186.sequences.fasta

# double check that originating lab is "Seattle Flu Study"
cat ${INPUT_METADATA} \
  | awk -F'\t' '{print $21}' \
  | sort \
  | uniq -c > originating_lab.txt

# 2. Download Nextclade pathogen dataset

nextclade dataset get \
  --name 'sars-cov-2' \
  --output-dir 'data/sars-cov-2' \
  --verbose

ls -ltr data/sars-cov-2 
#> total 5.9M
#>  username staff 2.1M tree.json
#>  username staff 3.7M sequences.fasta
#>  username staff  30K reference.fasta
#>  username staff 1021 genemap.gff
#>  username staff  889 tag.json
#>  username staff  27K qc.json
#>  username staff 2.3K primers.csv
#>  username staff  49K virus_properties.json

nextclade run \
  --input-dataset data/sars-cov-2 \
  --output-all=output/ \
  $INPUT_FASTA 

ls -ltr output 
#> total 150M
#> -rw-r--r-- 1 user staff  12M nextclade.aligned.fasta
#> -rw-r--r-- 1 user staff  41K nextclade_gene_E.translation.fasta
#> -rw-r--r-- 1 user staff  97K nextclade_gene_M.translation.fasta
#> -rw-r--r-- 1 user staff 173K nextclade_gene_N.translation.fasta
#> -rw-r--r-- 1 user staff 1.7M nextclade_gene_ORF1a.translation.fasta
#> -rw-r--r-- 1 user staff 1.1M nextclade_gene_ORF1b.translation.fasta
#> -rw-r--r-- 1 user staff 118K nextclade_gene_ORF3a.translation.fasta
#> -rw-r--r-- 1 user staff  35K nextclade_gene_ORF6.translation.fasta
#> -rw-r--r-- 1 user staff  58K nextclade_gene_ORF7a.translation.fasta
#> -rw-r--r-- 1 user staff  29K nextclade_gene_ORF7b.translation.fasta
#> -rw-r--r-- 1 user staff  58K nextclade_gene_ORF8.translation.fasta
#> -rw-r--r-- 1 user staff  49K nextclade_gene_ORF9b.translation.fasta
#> -rw-r--r-- 1 user staff 501K nextclade_gene_S.translation.fasta
#> -rw-r--r-- 1 user staff  81M nextclade.json
#> -rw-r--r-- 1 user staff  37M nextclade.ndjson
#> -rw-r--r-- 1 user staff 804K nextclade.csv
#> -rw-r--r-- 1 user staff 803K nextclade.tsv
#> -rw-r--r-- 1 user staff  12K nextclade.insertions.csv
#> -rw-r--r-- 1 user staff  12K nextclade.errors.csv
#> -rw-r--r-- 1 user staff  14M nextclade.auspice.json
