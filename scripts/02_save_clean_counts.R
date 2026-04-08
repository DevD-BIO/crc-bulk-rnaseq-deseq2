# Day 3 - Save clean counts table

counts_file <- "data_raw/GSE142279_raw_counts_GRCh38.p13_NCBI.tsv"
counts <- read.delim(counts_file, check.names = FALSE)

write.csv(counts, "data_processed/raw_counts_copy.csv", row.names = FALSE)

cat("Saved cleaned copy to data_processed/raw_counts_copy.csv\n")