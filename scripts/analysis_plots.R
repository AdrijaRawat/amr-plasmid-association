# AMR–Plasmid Association Analysis
# Klebsiella pneumoniae

setwd("~/amr-mini-project/results")

library(tidyverse)

# -------------------------------
# Load data
# -------------------------------

amr <- read_tsv(
  "amr_genes.tsv",
  col_names = c("Genome", "Gene")
)

plasmids <- read_tsv(
  "plasmids.tsv",
  col_names = c("Genome", "Plasmid")
)

pairs <- read_tsv(
  "gene_plasmid_pairs.tsv",
  col_names = c("Genome", "Gene", "Plasmid")
)

# -------------------------------
# Plot 1: AMR gene burden
# -------------------------------

amr_count <- amr %>%
  count(Genome) %>%
  mutate(Genome_ID = basename(Genome))

p1 <- ggplot(amr_count,
             aes(x = n, y = reorder(Genome_ID, n))) +
  geom_segment(aes(x = 0, xend = n, yend = Genome_ID),
               color = "grey70") +
  geom_point(size = 4, color = "steelblue") +
  labs(
    title = "AMR Gene Burden Across Klebsiella pneumoniae Genomes",
    x = "Number of resistance genes",
    y = "Genome"
  ) +
  theme_minimal()

ggsave("plot1_amr_burden.png", p1, width = 6, height = 4, dpi = 300)

# -------------------------------
# Plot 2: Plasmid replicon counts
# -------------------------------

plasmid_count <- plasmids %>%
  count(Plasmid)

p2 <- ggplot(plasmid_count,
             aes(x = reorder(Plasmid, n), y = n)) +
  geom_col(fill = "darkorange") +
  coord_flip() +
  labs(
    title = "Distribution of Plasmid Replicon Types",
    x = "Plasmid replicon",
    y = "Count"
  ) +
  theme_minimal()

ggsave("plot2_plasmid_distribution.png", p2, width = 6, height = 6, dpi = 300)

# -------------------------------
# Plot 3: Gene–plasmid heatmap
# -------------------------------

heatmap_data <- pairs %>%
  count(Gene, Plasmid)

p3 <- ggplot(heatmap_data,
             aes(x = Plasmid, y = Gene, fill = n)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "firebrick") +
  labs(
    title = "Plasmid–AMR Gene Co-occurrence Patterns",
    x = "Plasmid replicon",
    y = "Resistance gene",
    fill = "Count"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggsave("plot3_gene_plasmid_heatmap.png", p3, width = 10, height = 8, dpi = 300)

# -------------------------------
# Plot 4: Plasmid diversity per genome
# -------------------------------

plasmid_div <- plasmids %>%
  distinct(Genome, Plasmid) %>%
  count(Genome) %>%
  mutate(Genome_ID = basename(Genome))

p4 <- ggplot(plasmid_div,
             aes(x = n, y = reorder(Genome_ID, n))) +
  geom_segment(aes(x = 0, xend = n, yend = Genome_ID),
               color = "grey70") +
  geom_point(size = 4, color = "seagreen") +
  labs(
    title = "Plasmid Replicon Diversity Across Genomes",
    x = "Number of plasmid replicons",
    y = "Genome"
  ) +
  theme_minimal()

ggsave("plot4_plasmid_diversity.png", p4, width = 6, height = 4, dpi = 300)

# -------------------------------
# Plot 5: Gene distribution across plasmids
# -------------------------------

gene_promiscuity <- pairs %>%
  distinct(Gene, Plasmid) %>%
  count(Gene)

p5 <- ggplot(gene_promiscuity,
             aes(x = n, y = reorder(Gene, n))) +
  geom_segment(aes(x = 0, xend = n, yend = Gene),
               color = "grey70") +
  geom_point(size = 3, color = "firebrick") +
  labs(
    title = "Distribution of Resistance Genes Across Plasmid Replicon Types",
    x = "Number of plasmid replicon types",
    y = "Resistance gene"
  ) +
  theme_minimal(base_size = 11)

ggsave("plot5_gene_plasmid_distribution.png", p5,
       width = 7, height = 10, dpi = 300)
