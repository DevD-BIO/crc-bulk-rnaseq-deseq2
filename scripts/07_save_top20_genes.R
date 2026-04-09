# Load significant genes
sig_res <- read.csv("results/deseq2_significant_genes.csv", stringsAsFactors = FALSE)

# Take top 20 by adjusted p-value
top20 <- head(sig_res, 20)

# Save top 20
write.csv(top20, "results/top20_genes_by_padj.csv", row.names = FALSE)

cat("Saved top 20 genes to results/top20_genes_by_padj.csv\n")
print(top20)