# set working directory
setwd("//wsl$/Ubuntu/home/nav/amr-mini-project/results")

library(tidyverse)

pairs <- read_tsv(
  "gene_plasmid_pairs.tsv",
  col_names = c("Genome", "Gene", "Plasmid")
)

heatmap_data <- pairs %>%
  count(Gene, Plasmid) %>%
  filter(n >= 2)

ggplot(heatmap_data, aes(Plasmid, Gene, fill = n)) +
  geom_tile(color = "grey80", linewidth = 0.3) +
  scale_fill_gradient(
    low = "grey85",
    high = "firebrick",
    name = "Co-occurrence\n(count)"
  ) +
  labs(
    title = "Plasmid–AMR Gene Co-occurrence",
    x = "Plasmid replicon type",
    y = "Resistance gene"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    axis.line = element_line(color = "black", linewidth = 0.6),
    panel.grid = element_blank()
  )


