library(EnhancedVolcano)

dir.create("figures", showWarnings = FALSE)

# load results with symbols
res_df <- read.csv("results/deseq2_full_results_with_symbols.csv", stringsAsFactors = FALSE)

# keep only rows with valid padj
plot_df <- res_df[!is.na(res_df$padj), ]
plot_df <- plot_df[order(plot_df$padj), ]

# top labels
top_labels <- unique(head(plot_df$GeneLabel, 15))

# build plot object
p <- EnhancedVolcano(
  plot_df,
  lab = plot_df$GeneLabel,
  x = "log2FoldChange",
  y = "padj",
  selectLab = top_labels,
  pCutoff = 0.05,
  FCcutoff = 1,
  title = "Colorectal Tumor vs Normal",
  subtitle = "DESeq2 differential expression",
  caption = "Cutoffs: padj < 0.05 and |log2FC| > 1",
  pointSize = 2.0,
  labSize = 4.0
)

# save plot
png("figures/volcano_plot.png", width = 1400, height = 1100, res = 150)
print(p)
dev.off()

cat("Saved volcano plot to figures/volcano_plot.png\n")
print(list.files("figures"))
print(file.exists("figures/volcano_plot.png"))