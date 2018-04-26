library(ggplot2)
library(dplyr)

emp_satisfaction.df <- satisfaction.df %>% 
	select(EmployeeNumber, EnvironmentSatisfaction, RelationshipSatisfaction, JobSatisfaction, JobInvolvement, Department) %>% 
	gather("Area", "Rating", EnvironmentSatisfaction, RelationshipSatisfaction, JobSatisfaction, JobInvolvement)

ggplot(emp_satisfaction.df) +
	aes(x = Area, fill = Rating) + 
	geom_bar()

dept_satisfaction.df <- emp_satisfaction.df %>% 
	filter(Area == "JobSatisfaction") %>% 
	group_by(Department, Area, Rating) %>% 
	summarise(count = n_distinct(EmployeeNumber)) %>% 
	mutate(Share = prop.table(count))
	ungroup()

ggplot(dept_satisfaction.df) +
	aes(x = 1, y = Share, fill = Rating) + 
	geom_bar(stat = "identity") +
	scale_x_discrete(expand = c(0.50, 0)) +
	facet_wrap(~ Department) +
	coord_polar(theta = "y") 


