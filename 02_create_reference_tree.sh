#! /usr/bin/env bash
set -euv

# === Input files
INFILE="sequences.fasta"
META="metadata.tsv"
REF="reference.fasta"
REF_GFF="genemap.gff" # Swap this out for correct reference GenBank or GFF

[[ -d "results" ]] || mkdir results

augur align \
  --sequences ${INFILE} \
  --reference-sequence ${REF} \
  --output results/aln.fasta \
  --fill-gaps \
  --nthreads `nproc`

# cat ${INFILE} \
#  | nextalign run \
#   --jobs=`nproc` \
#   --reference ${REF} \
#   --genemap ${REF_GFF} \
#   --output-translations translations_{gene}.txt \
#   --output-fasta results/aln.fasta

augur tree \
  --alignment results/aln.fasta \
  --output results/tree.nwk \
  --nthreads `nproc`

augur refine \
  --tree results/tree.nwk \
  --alignment results/aln.fasta \
  --metadata metadata.tsv \
  --output-tree results/refined_tree.nwk \
  --output-node-data results/branch_labels.json

augur ancestral \
  --tree results/refined_tree.nwk \
  --alignment results/aln.fasta \
  --output-node-data results/nt-muts.json \
  --inference joint

augur translate \
  --tree results/refined_tree.nwk \
  --ancestral-sequences results/nt-muts.json \
  --reference-sequence ${REF_GFF} \
  --output results/aa-muts.json

augur traits \
  --tree results/refined_tree.nwk \
  --metadata metadata.tsv \
  --output results/clade_membership.json \
  --columns clade_membership 

augur export v2 \
  --tree results/refined_tree.nwk \
  --node-data \
    results/branch_labels.json \
    results/clade_membership.json \
    results/nt-muts.json \
    results/aa-muts.json \
  --output results/tree.json \
  --auspice-config auspice_config.json

echo "Done! look at results/tree.json"
echo "nextstrain view results/tree.json"

# zip into dengue.zip
# nextclade run -D dengue.zip -j 4 \
#   --output-fasta output_alignment.fasta \
#   --output-translations translations_{gene}.zip \
#   --output-insertions insertions.csv \
#   sequences.fasta