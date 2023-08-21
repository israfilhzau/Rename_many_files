# Set the folder path
folder_path <- "C:/Users/israf/Documents/test"

# Get a list of all FNA files in the folder
file_list <- list.files(folder_path, pattern = "\\.fna$", full.names = TRUE)

# Process and rename the files using header information
for (i in 1:length(file_list)) {
  fna_content <- readLines(file_list[i])
  header_line <- grep("^>", fna_content)[1]  # Get the first header line
  
  if (!is.na(header_line)) {
    header <- sub("^>", "", fna_content[header_line])
    
    # Sanitize the header to create a valid file name
    sanitized_header <- gsub("[^A-Za-z0-9._-]", "_", header)
    
    new_name <- file.path(folder_path, paste0(sanitized_header, ".fna"))
    
    # Rename the file
    file.rename(file_list[i], new_name)
  }
}

# Print a message indicating completion
cat("File header-based renaming completed.")
