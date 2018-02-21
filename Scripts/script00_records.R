# Initialise ####
# Copy-paste this chunk at beginning of R scripts

cache.path <- file.path(".", "Data")
stage.path <- file.path("~/Data", "employee-surveys")

source("./Scripts/template.R")

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

## _Hike-Tenure trends ####

labelFirst.years <- function(x){
	x.lab <- c("years", rep("", length(x) - 1))
	out.lab <- paste(x, x.lab)
	return(out.lab)
}

ggplot(records.df) +
	scale_y_continuous(labels = percent) +
	scale_x_continuous(labels = labelFirst.years) +
	geom_point(
		aes(x = YearsAtCompany, y = SalaryHike),
		position = "jitter", alpha = 1/3, pch = 19
	) +
	theme(
		plot.background = element_blank(),
		panel.background = element_blank(),
		axis.line = element_line(colour ="black")
	)
ggsave("./Plots/plot00_trend_salaryhikeVStenure.png")

## _Salary-xp trends ####

labelLast.usd <- function(x){
	require(scales)
	x.lab <- c(rep("", length(x) - 1), "USD")
	out.lab <- paste(x.lab, comma(x))
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

## _Dept composition ####

library(dplyr)
library(treemapify)

dept.df <- records.df %>% 
	group_by(Department) %>% 
	summarise(
		Plantilla = n() # Assumes unique employees
	) %>% 
	ungroup()

roles.df <- records.df %>% 
	group_by(Department, JobRole) %>% 
	summarise(
		Plantilla = n()
	) %>% 
	ungroup()

dept.cols <- dataseer.cols[1:countDistinct(roles.df$Department)]
names(dept.cols) <- unique(roles.df$Department)

ggplot(roles.df) +
	aes(
		area = Plantilla, subgroup = Department,
		label = JobRole, fill = Department
	) +
	# Job Roles
	geom_treemap(colour = "white") +
	# geom_treemap_text(place = "bottomright", colour = "black") +
	# Dept
	geom_treemap_subgroup_border(colour = NA) +
	geom_treemap_subgroup_text(place = "topleft", fontface = "italic", colour = "black") +
	# Refine
	scale_fill_manual(guide = TRUE, values = dept.cols) +
	# guides(fill = guide_legend(reverse = TRUE))
	theme(
		legend.title = element_text(face = "bold"),
		legend.text = element_text(face = "italic")
	)
ggsave("./Plots/plot02_parts_dept-composition.png")
