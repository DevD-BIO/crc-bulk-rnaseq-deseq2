# Load full results
res_df <- read.csv("results/deseq2_full_results.csv", stringsAsFactors = FALSE)

# Keep only significant genes
sig_res <- res_df[!is.na(res_df$padj) & res_df$padj < 0.05, ]

# Sort by adjusted p-value
sig_res <- sig_res[order(sig_res$padj), ]

# Save significant genes
write.csv(sig_res, "results/deseq2_significant_genes.csv", row.names = FALSE)

cat("Saved significant genes to results/deseq2_significant_genes.csv\n")
cat("Number of significant genes:\n")
print(nrow(sig_res))