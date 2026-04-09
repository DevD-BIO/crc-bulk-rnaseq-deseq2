library(DESeq2)

# Load the saved DESeq2 object
dds <- readRDS("data_processed/dds_object.rds")

# Run DESeq2
dds <- DESeq(dds)

# Save the fitted object
saveRDS(dds, file = "data_processed/dds_fitted.rds")

# Get results: tumor vs normal
res <- results(dds, contrast = c("condition", "tumor", "normal"))

# Convert to data frame
res_df <- as.data.frame(res)
res_df$GeneID <- rownames(res_df)

# Reorder columns so GeneID comes first
res_df <- res_df[, c("GeneID", "baseMean", "log2FoldChange", "lfcSE", "stat", "pvalue", "padj")]

# Sort by adjusted p-value
res_df <- res_df[order(res_df$padj), ]

# Save full results
write.csv(res_df, "results/deseq2_full_results.csv", row.names = FALSE)

# Print summary
cat("DESeq2 finished.\n")
cat("Full results saved to results/deseq2_full_results.csv\n\n")

cat("Dimensions of results table:\n")
print(dim(res_df))

cat("\nTop 10 rows:\n")
print(head(res_df, 10))

cat("\nHow many genes have adjusted p-value < 0.05?\n")
print(sum(res_df$padj < 0.05, na.rm = TRUE))