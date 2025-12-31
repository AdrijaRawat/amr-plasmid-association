# set working directory
setwd("//wsl$/Ubuntu/home/nav/amr-mini-project/results")

library(tidyverse)

# load gene–plasmid pairs
pairs <- read_tsv(
  "gene_plasmid_pairs.tsv",
  col_names = c("Genome", "Gene", "Plasmid")
)

# calculate plasmid promiscuity
plasmid_promiscuity <- pairs %>%
  distinct(Gene, Plasmid) %>%     # unique gene–plasmid links
  count(Plasmid)                  # number of genes per plasmid

# plot plasmid promiscuity
ggplot(plasmid_promiscuity,
       aes(x = n, y = reorder(Plasmid, n))) +
  geom_segment(aes(x = 0, xend = n, yend = Plasmid),
               color = "grey70") +
  geom_point(size = 4, color = "steelblue") +
  labs(
    title = "Plasmid Promiscuity in AMR Gene Carriage",
    x = "Number of unique resistance genes",
    y = "Plasmid replicon type"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    axis.title.x = element_text(face = "bold"),
    axis.title.y = element_text(face = "bold"),
    panel.grid.minor = element_blank()
  )


