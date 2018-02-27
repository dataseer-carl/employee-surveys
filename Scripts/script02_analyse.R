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

#! Did not download anymore

# Load
data00.path <- file.path(local.path, "data00_load.RData")
load(data00.path)
