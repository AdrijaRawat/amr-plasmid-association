#!/bin/bash

# ==========================================
# AMR–Plasmid Association Workflow
# Klebsiella pneumoniae
# ==========================================

# This script documents the complete workflow used in this project:
# 1. Download genomes from NCBI
# 2. Identify AMR genes using ResFinder
# 3. Identify plasmid replicons using PlasmidFinder
# 4. Generate summary tables for downstream analysis

# ------------------------------------------
# STEP 1: Create project directories
# ------------------------------------------

mkdir -p ../data/genomes
mkdir -p ../results

# ------------------------------------------
# STEP 2: Download genomes from NCBI
# ------------------------------------------

cd ../data/genomes

datasets download genome accession \
  GCF_023546055.1 \
  GCF_022869665.1 \
  GCF_014946945.1 \
  GCF_014840245.1 \
  GCF_014840645.1 \
  --include genome \
  --filename kp_dataset.zip

unzip kp_dataset.zip -d kp_data
find kp_data -name "*.fna" -exec mv {} . \;
rm -rf kp_data kp_dataset.zip

# ------------------------------------------
# STEP 3: Run ResFinder (AMR genes)
# ------------------------------------------

cd ../../scripts

abricate --db resfinder ../data/genomes/*.fna \
  > ../results/resfinder.tsv

# ------------------------------------------
# STEP 4: Run PlasmidFinder (plasmid replicons)
# ------------------------------------------

abricate --db plasmidfinder ../data/genomes/*.fna \
  > ../results/plasmidfinder.tsv

# ------------------------------------------
# STEP 5: Extract AMR gene table
# ------------------------------------------

cd ../results

awk 'NR>1 {print $1 "\t" $6}' resfinder.tsv \
  > amr_genes.tsv

# ------------------------------------------
# STEP 6: Extract plasmid table
# ------------------------------------------

awk 'NR>1 {print $1 "\t" $6}' plasmidfinder.tsv \
  > plasmids.tsv

# ------------------------------------------
# STEP 7: Create gene–plasmid pairing table
# ------------------------------------------

join -t $'\t' \
  <(sort amr_genes.tsv) \
  <(sort plasmids.tsv) \
  > gene_plasmid_pairs.tsv

# ------------------------------------------
# Workflow complete
# ------------------------------------------

echo "AMR–plasmid workflow completed."
