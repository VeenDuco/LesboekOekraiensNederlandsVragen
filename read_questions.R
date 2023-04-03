library(readxl)
library(dplyr)
library(jsonlite)

read_questions <- function(file_path) {
  questions_df <- read_excel(file_path)
  questions_df <- questions_df %>%
    mutate(id = row_number()) %>%
    select(id, everything())
  return(questions_df)
}

write_questions_json <- function(questions, file_path) {
  questions_json <- toJSON(questions, pretty = TRUE)
  write(questions_json, file_path)
}

