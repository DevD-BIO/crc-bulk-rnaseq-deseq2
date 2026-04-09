library(org.Hs.eg.db)
library(AnnotationDbi)

# load DESeq2 full results
res_df <- read.csv("results/deseq2_full_results.csv", stringsAsFactors = FALSE)

# convert GeneID to character
res_df$GeneID <- as.character(res_df$GeneID)

# map Entrez GeneID -> gene symbol
res_df$Symbol <- mapIds(
  org.Hs.eg.db,
  keys = res_df$GeneID,
  column = "SYMBOL",
  keytype = "ENTREZID",
  multiVals = "first"
)

# if symbol is missing, keep GeneID as fallback label
res_df$GeneLabel <- ifelse(is.na(res_df$Symbol) | res_df$Symbol == "", res_df$GeneID, res_df$Symbol)

# save full table with symbols
write.csv(res_df, "results/deseq2_full_results_with_symbols.csv", row.names = FALSE)

# save top 20 with symbols too
top20 <- head(res_df[order(res_df$padj), ], 20)
write.csv(top20, "results/top20_genes_with_symbols.csv", row.names = FALSE)

cat("Saved results with gene symbols.\n")
cat("Rows in full results:", nrow(res_df), "\n")
cat("Rows in top20 file:", nrow(top20), "\n")