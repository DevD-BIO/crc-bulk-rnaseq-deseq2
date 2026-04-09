library(DESeq2)
library(pheatmap)

dds <- readRDS("data_processed/dds_object.rds")
vsd <- vst(dds, blind = FALSE)

res_df <- read.csv("results/deseq2_full_results_with_symbols.csv", stringsAsFactors = FALSE)

sig_df <- res_df[!is.na(res_df$padj) & res_df$padj < 0.05, ]
sig_df <- sig_df[order(sig_df$padj), ]
top30 <- head(sig_df, 30)

mat <- assay(vsd)
top_gene_ids <- as.character(top30$GeneID)
mat_top <- mat[rownames(mat) %in% top_gene_ids, ]
mat_top <- mat_top[top_gene_ids, , drop = FALSE]

gene_labels <- top30$GeneLabel
gene_labels[is.na(gene_labels) | gene_labels == ""] <- top30$GeneID[is.na(gene_labels) | gene_labels == ""]
rownames(mat_top) <- make.unique(gene_labels)

sample_annot <- as.data.frame(colData(vsd)[, c("condition", "patient_id")])

png("figures/top30_heatmap.png", width = 1400, height = 1200, res = 150)

pheatmap(
  mat_top,
  scale = "row",
  annotation_col = sample_annot,
  show_rownames = TRUE,
  show_colnames = FALSE,
  fontsize_row = 9,
  main = "Top 30 Differentially Expressed Genes"
)

dev.off()

cat("Saved heatmap to figures/top30_heatmap.png\n")
print(list.files("figures"))
print(file.exists("figures/top30_heatmap.png"))