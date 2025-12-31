# Set working directory
setwd("//wsl$/Ubuntu/home/nav/amr-mini-project/results")

# Load library
library(tidyverse)

# Load plasmid data
plasmids <- read_tsv(
  "plasmids.tsv",
  col_names = c("Genome", "Plasmid")
)

# Count plasmid frequencies
plasmid_count <- plasmids %>%
  count(Plasmid) %>%
  arrange(n)

# Clean dot plot (no overlap)
ggplot(plasmid_count,
       aes(x = n, y = reorder(Plasmid, n))) +
  geom_point(
    size = 4,
    color = "black"
  ) +
  labs(
    title = "Frequency of Plasmid Replicons",
    x = "Number of Genomes Carrying Replicon",
    y = "Plasmid Replicon Type"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.major.y = element_blank(),
    panel.grid.minor = element_blank()
  )
