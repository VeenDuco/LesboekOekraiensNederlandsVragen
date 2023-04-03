library(readxl)
library(dplyr)
library(writexl)
library(jsonlite)

# Function to read a single Excel file
read_file <- function(file_path) {
  df <- read_excel(file_path)
  return(df)
}

# List all input files
input_files <- list.files(path = "./vragenbank", pattern = "^ch02_sec.*\\.xlsx$", 
                          include.dirs = TRUE, full.names = TRUE)

# Read and combine data from all input files
combined_df <- bind_rows(lapply(input_files, read_file))

# Write the combined data to a new .xlsx file to check easily
write_xlsx(combined_df, "vragenbank/ch02_combined_questions_answers_mc.xlsx")
# Write the combined data to a new .json file
write_questions_json <- function(questions, file_path) {
  questions_json <- toJSON(questions, pretty = TRUE)
  write(questions_json, file_path)
}

write_questions_json(combined_df, "docs/ch02_combined_questions_answers_mc.json")
