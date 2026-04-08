counts_file <- "data_raw/GSE142279_raw_counts_GRCh38.p13_NCBI.tsv"
metadata_file <- "metadata/sample_metadata_backup.csv"

counts <- read.delim(counts_file, check.names = FALSE)
metadata <- read.csv(metadata_file, stringsAsFactors = FALSE)

sample_order <- metadata$gsm_id

clean_counts <- counts[, c("GeneID", sample_order)]
write.csv(clean_counts, "data_processed/clean_counts_with_geneid.csv", row.names = FALSE)

count_matrix <- clean_counts[, -1]
rownames(count_matrix) <- clean_counts$GeneID
count_matrix <- as.matrix(count_matrix)
mode(count_matrix) <- "numeric"
write.csv(count_matrix, "data_processed/deseq2_count_matrix.csv")

sample_info <- metadata[, c("gsm_id", "sample_id", "patient_id", "condition")]
rownames(sample_info) <- sample_info$gsm_id
write.csv(sample_info, "data_processed/deseq2_sample_info.csv", row.names = FALSE)

print(all(colnames(count_matrix) == rownames(sample_info)))