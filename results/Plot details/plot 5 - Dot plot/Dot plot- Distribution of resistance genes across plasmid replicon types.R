# set working directory
setwd("//wsl$/Ubuntu/home/nav/amr-mini-project/results")

# load libraries
library(tidyverse)

# load gene–plasmid pairs
pairs <- read_tsv(
  "gene_plasmid_pairs.tsv",
  col_names = c("Genome", "Gene", "Plasmid")
)

# calculate gene–plasmid associations
gene_promiscuity <- pairs %>%
  distinct(Gene, Plasmid) %>%
  count(Gene)

# create the plot
p5 <- ggplot(gene_promiscuity,
             aes(x = n, y = reorder(Gene, n))) +
  geom_segment(
    aes(x = 0, xend = n, yend = Gene),
    color = "grey70"
  ) +
  geom_point(size = 3, color = "firebrick") +
  labs(
    title = "Distribution of Resistance Genes Across Plasmid Replicon Types",
    x = "Number of plasmid replicon types",
    y = "Resistance gene"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.text.y = element_text(size = 7),
    panel.grid.minor = element_blank()
  )

# display the plot
print(p5)

# save with sufficient height to avoid label overlap
ggsave(
  "plot5_gene_plasmid_distribution.png",
  p5,
  width = 7,
  height = 10,
  dpi = 300
)
