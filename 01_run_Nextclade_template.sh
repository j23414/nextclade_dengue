#! /usr/bin/env bash

# Generate the Nextclade template for all, denv1, denv2, denv3

git clone https://github.com/nextstrain/nextclade_dataset_template.git
cd nextclade_dataset_template

python generate_from_genbank.py \
  --reference NC_001477 \
  --output-dir denv1

python generate_from_genbank.py \
  --reference NC_001474 \
  --output-dir denv2

python generate_from_genbank.py \
  --reference NC_001475 \
  --output-dir denv3

python generate_from_genbank.py \
  --reference NC_002640 \
  --output-dir denv4

python generate_from_genbank.py \
  --reference NC_002640 \
  --output-dir all

cd ..
cp -r nextclade_dataset_template/denv1/files denv1
cp -r nextclade_dataset_template/denv2/files denv2
cp -r nextclade_dataset_template/denv3/files denv3
cp -r nextclade_dataset_template/denv4/files denv4
cp -r nextclade_dataset_template/all/files all


