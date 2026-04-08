library(DESeq2)

count_matrix <- read.csv("data_processed/deseq2_count_matrix.csv", row.names = 1, check.names = FALSE)
sample_info <- read.csv("data_processed/deseq2_sample_info.csv", stringsAsFactors = FALSE)

rownames(sample_info) <- sample_info$gsm_id

# clean condition values
sample_info$condition <- trimws(sample_info$condition)
sample_info$condition <- tolower(sample_info$condition)
sample_info$condition[sample_info$condition == "tumour"] <- "tumor"

sample_info$condition <- factor(sample_info$condition, levels = c("normal", "tumor"))
sample_info$patient_id <- factor(sample_info$patient_id)

count_matrix <- as.matrix(count_matrix)
mode(count_matrix) <- "integer"

dds <- DESeqDataSetFromMatrix(
  countData = count_matrix,
  colData = sample_info,
  design = ~ patient_id + condition
)

dds <- dds[rowSums(counts(dds)) >= 10, ]

saveRDS(dds, file = "data_processed/dds_object.rds")

print(dim(dds))