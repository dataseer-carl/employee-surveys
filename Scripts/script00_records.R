# Initialise ####
# Copy-paste this chunk at beginning of R scripts

cache.path <- file.path(".", "Data")
stage.path <- file.path("~/Data", "employee-surveys")

#*******************************

# Load ####

library(readr)
library(googledrive)

records.file <- "Employee records.csv"
records.cache <- file.path(cache.path, records.file) # Path to local

records.raw <- read_csv(records.cache)

## Only corrections to metadata: factors
records.df <- records.raw

## Upload parsed data
records.parsed <- file.path(cache.path, "records.rds")
saveRDS(records.df, records.parsed)
drive_upload(records.parsed, paste0(stage.path, "/"))

# EDA ####

library(ggplot2)
library(scales)

records.df <- readRDS(records.parsed)

ggplot(records.df) +
	geom_point(
		aes(x = YearsAtCompany, y = SalaryHike),
		position = "jitter", alpha = 1/3, pch = 19
	)

ggplot(records.df) +
	geom_point(
		aes(x = YearsSinceLastPromotion, y = SalaryHike),
		position = "jitter", alpha = 1/3, pch = 19
	)

## _Salary-xp trends ####

labelFirst.years <- function(x){
	x.lab <- c("years", rep("", length(x) - 1))
	out.lab <- paste(x, x.lab)
	return(out.lab)
}
labelLast.usd <- function(x){
	require(scales)
	x.lab <- c(rep("", length(x) - 1), "USD")
	out.lab <- paste(x.lab, x)
	return(out.lab)
}

ggplot(records.df) +
	geom_point(
		aes(x = TotalWorkingYears, y = MonthlyIncome),
		position = "jitter", alpha = 1/3, pch = 19
	) +
	scale_y_continuous(labels = labelLast.usd) +
	scale_x_continuous(labels = labelFirst.years) +
	theme(
		plot.background = element_blank(),
		panel.background = element_blank(),
		axis.line = element_line(colour ="black")
	)
ggsave("./Plots/plot01_trend_salaryVSxp.png")
