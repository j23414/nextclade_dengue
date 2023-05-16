#! /usr/bin/env bash

# Subsample the dengue tree to something more manageable
smot sample para \
  --proportion=0.01 \
  dengue_references.tre \
  --factor-by-field=4 \
  --newick \
  > dengue_sampled_small.tre

# Pull IDs

# Pull ID records from metadata_all.tsv and sequences.fasta

# End goal is to generate a WGS Dengue Nextclade dataset