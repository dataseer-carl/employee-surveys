# Initialise ####
# Copy-paste this chunk at beginning of R scripts

cache.path <- file.path(".", "Data")
stage.path <- file.path("~/Data", "employee-surveys")

#*******************************

library(googledrive)

drive_auth() # Authenticate session w/ GDrive

# Show files
drive_ls(stage.path)

## records ####

### Set paths
records.file <- "Employee records.csv"
records.cache <- file.path(cache.path, records.file) # Path to local
records.source <- file.path(stage.path, records.file) # Path in data://

### DL
records.id <- records.source %>% drive_get() %>% as_id()
drive_download(records.id, records.cache, overwrite = TRUE)
