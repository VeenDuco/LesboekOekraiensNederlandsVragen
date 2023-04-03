library(readxl)
library(writexl)
library(dplyr)
library(jsonlite)

# List of input .xlsx files
input_files <- list.files(path = "./vragenbank", pattern = "^ch02_sec.*\\.xlsx$",
                          include.dirs = TRUE, full.names = TRUE)

# Read and combine data from multiple .xlsx files
combined_data <- lapply(input_files, function(file) {
  data <- read_excel(file)
  data <- data %>% select(question, correct_answer)
}) %>% bind_rows()

# Rename the correct_answer column to answer
combined_data <- combined_data %>% rename(answer = correct_answer)

# Write the combined data to a new .xlsx file to check easily
write_xlsx(combined_data, "vragenbank/ch02_combined_questions_answers.xlsx")
# Write the combined data to a new .json file
write_questions_json <- function(questions, file_path) {
  questions_json <- toJSON(questions, pretty = TRUE)
  write(questions_json, file_path)
}

write_questions_json(combined_data, "docs/ch02_combined_questions_answers.json")