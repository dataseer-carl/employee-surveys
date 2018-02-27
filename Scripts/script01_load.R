# Initialise paths ##################################################
# Copy paste at beginning of every R script
# Edit as appropriate

project.name <- "employee-surveys"

## DataLake

author.name <- "IBM Watson"
data.source <- "HR Employee Attrition"

## Path to data://
source.path <- file.path("~/Data/DataLake", author.name, data.source)
source.path <- file.path(source.path, "data")

library(googledrive)
drive_auth()

## Repo

data.path <- file.path("~/Data", project.name)
local.path <- "./Data"

#*******************************************************************#

# View extant files in project data://
data.path %>% drive_ls()

# Download files
get.files <- c("Employee records.csv", "Employee Surveys.xlsx")
lapply(
	get.files,
	function(temp.file){
		# temp.file <- get.files[1]
		dataset.file <- data.path %>% 
			file.path(temp.file) %>% ## Select file for download
			drive_get()
		dataset.id <- as_id(dataset.file) ## Get ID for download
		dataset.path <- file.path(local.path, dataset.file$name) # Assumes nrow = 1
		drive_download(dataset.id, path = dataset.path, overwrite = TRUE) ## Download raw data file
	}
)

# Employee recrods.csv ####

library(readr)

records.path <- file.path(local.path, get.files[1])
records.df <- read_csv(records.path)

# Employee Surveys.xlsx ####

library(readxl)

surveys.path <- file.path(local.path, get.files[2])
surveys.sheets <- excel_sheets(surveys.path)
names(surveys.sheets) <- surveys.sheets

surveys.ls <- lapply(
	surveys.sheets,
	function(temp.sheet){
		temp.df <- read_excel(surveys.path, sheet = temp.sheet)
		return(temp.df)
	}
)

## Parse
# surveys.ls %>% lapply(function(temp.df) lapply(temp.df, unique))

library(magrittr)

records.df$Education %<>% 
	factor(levels = c("Below College", "College", "Bachelor", "Master", "Doctor"))

surveys.ls$`Satisfaction survey`$EnvironmentSatisfaction %<>% 
	factor(levels = c("Low", "Medium", "High", "Very high"))

surveys.ls$`Satisfaction survey`$RelationshipSatisfaction%<>% 
	factor(levels = c("Low", "Medium", "High", "Very high"))

surveys.ls$`Satisfaction survey`$JobSatisfaction%<>% 
	factor(levels = c("Low", "Medium", "High", "Very high"))
	
surveys.ls$`Satisfaction survey`$JobInvolvement %<>% 
	factor(levels = c("Low", "Medium", "High", "Very high"))

surveys.ls$`Satisfaction survey`$WorkLifeBalance %<>% 
	factor(levels = c("Bad", "Good", "Better", "Best"))
	
surveys.ls$`Performance rating survey`$PerformanceRating %<>% 
	factor(levels = c("Low", "Good", "Excellent", "Outstanding")) 

surveys.ls$`Performance rating survey`$BusinessTravel %<>% 
	factor(levels = c("Non-Travel", "Rarely", "Frequently")) 

data00.path <- file.path(local.path, "data00_load.RData")
save(records.df, surveys.ls, file = data00.path)
drive_upload(data00.path, paste0(data.path, "/"))
