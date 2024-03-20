library(stringr)

# Function to convert Rmd to Quarto format
convert_to_quarto <- function(input_file, output_file) {
  # Read the contents of the file
  content <- readLines(input_file, warn = FALSE)

  # Perform the substitutions

  # 1. Delete all instances of "---" after the first two
  content <- sub("---\n", "", content, fixed = TRUE)
  content <- sub("---\n", "", content, fixed = TRUE)
  content <- gsub("---", "", content)

  # 2. Replace all "--" by ". . ."
  content <- str_replace_all(content, "--", ". . .")

  # 3. Replace specific block structure
  content <- str_replace_all(content, 
    "\\n\\.pull-left\\[\\n(.*?)\\n\\]\\n\\n\\.pull-right\\[\\n(.*?)\\n\\]\\n", 
    "::: {.columns}\n::: {.column}\n\\1\n:::\n::: {.column}\n\\2\n:::\n:::\n")

  # 4. Replace <img src="%CONTENT%", ?.> by ![](%CONTENT%)
  content <- str_replace_all(content, "<img src=\"(.*?)\", ?\\.>", "![](\\1)")

  # Write the modified content to the output file
  writeLines(content, output_file)
}

# Example usage
convert_to_quarto("slides/lecture_6_1/6_2_Estimation review.Rmd", "slides/lecture_6_1/6_2_Estimation_review.qmd")
