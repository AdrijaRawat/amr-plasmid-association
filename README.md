# Plasmid–AMR Association Analysis in Klebsiella pneumoniae

## Overview
This project explores the relationship between antimicrobial resistance (AMR) genes and plasmid replicon types in *Klebsiella pneumoniae* using publicly available genome assemblies. The analysis focuses on identifying non-random gene–plasmid association patterns and resistance genes with broader plasmid association.

## Data
- 5 *Klebsiella pneumoniae* RefSeq genomes
- AMR genes identified using ResFinder
- Plasmid replicons identified using PlasmidFinder

## Methods
1. Genome assemblies were screened for AMR genes using ResFinder (via Abricate).
2. Plasmid replicon types were identified using PlasmidFinder.
3. Gene–plasmid co-occurrence tables were generated using Bash.
4. Data visualisation and analysis were performed in R using ggplot2.

## Key Findings
- AMR gene burden varied across genomes.
- A limited number of plasmid replicon types dominated the dataset.
- Certain resistance genes showed consistent association with specific plasmid backbones.
- Some resistance genes were associated with multiple plasmid types, indicating higher dissemination potential.

## Significance
This analysis highlights the importance of plasmid backbones in shaping antimicrobial resistance patterns and demonstrates how integrative gene–plasmid analysis provides insights beyond simple resistance gene detection.

## Tools Used
- Abricate (ResFinder, PlasmidFinder)
- Bash (Ubuntu / WSL)
- R (tidyverse, ggplot2)


