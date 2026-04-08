# Day 3 - Load and check raw RNA-seq counts

# Set file paths
counts_file <- "data_raw/GSE142279_raw_counts_GRCh38.p13_NCBI.tsv"
annot_file <- "data_raw/Human.GRCh38.p13.annot.tsv"
metadata_file <- "metadata/sample_metadata_backup.csv"

# Read files
counts <- read.delim(counts_file, check.names = FALSE)
annot <- read.delim(annot_file, check.names = FALSE)
metadata <- read.csv(metadata_file, stringsAsFactors = FALSE)

# Show basic information
cat("Counts file loaded.\n")
cat("Annotation file loaded.\n")
cat("Metadata file loaded.\n\n")

cat("Counts dimensions:\n")
print(dim(counts))

cat("\nAnnotation dimensions:\n")
print(dim(annot))

cat("\nMetadata dimensions:\n")
print(dim(metadata))

cat("\nFirst 10 column names from counts:\n")
print(colnames(counts)[1:10])

cat("\nFirst 6 rows of metadata:\n")
print(head(metadata))

# Check GEO accession IDs against count columns
count_columns <- colnames(counts)
metadata_gsm <- metadata$gsm_id

matches <- metadata_gsm %in% count_columns

cat("\nGSM ID match check:\n")
print(data.frame(gsm_id = metadata_gsm, found_in_counts = matches))

cat("\nNumber of matched GSM IDs:\n")
print(sum(matches))

# Save match table
match_table <- data.frame(
  gsm_id = metadata$gsm_id,
  sample_id = metadata$sample_id,
  patient_id = metadata$patient_id,
  condition = metadata$condition,
  found_in_counts = matches
)

write.csv(match_table, "results/sample_id_match_check.csv", row.names = FALSE)

cat("\nSaved: results/sample_id_match_check.csv\n")