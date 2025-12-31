> #################################################
# AMR Gene Burden per Genome
# Klebsiella pneumoniae – Mini Project
#################################################

# 1️⃣ Set working directory (WSL → Windows bridge)
setwd("//wsl$/Ubuntu/home/nav/amr-mini-project/results")

# 2️⃣ Load required libraries
library(tidyverse)

# 3️⃣ Read AMR gene data
amr <- read_tsv(
  "amr_genes.tsv",
  col_names = c("Genome", "Gene")
)

# 4️⃣ Count AMR genes per genome
amr_count <- amr %>%
  count(Genome)

# 5️⃣ Clean genome labels for plotting
amr_count <- amr_count %>%
  mutate(
    Genome_ID = basename(Genome),
    Genome_ID = sub("_genomic.fna$", "", Genome_ID)
  )

# 6️⃣ Professional dot / lollipop-style plot
ggplot(amr_count,
       aes(x = n, y = reorder(Genome_ID, n))) +
  geom_segment(
    aes(x = 0, xend = n, yend = Genome_ID),
    color = "grey70"
  ) +
  geom_point(size = 4, color = "steelblue") +
  labs(
    title = "AMR Gene Burden Across Klebsiella pneumoniae Genomes",
    x = "Number of Resistance Genes",
    y = "Genome"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.y = element_text(size = 10),
    panel.grid.minor = element_blank()
  )
