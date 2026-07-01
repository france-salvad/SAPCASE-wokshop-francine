# Data wrangling (cleaning, filtering, etc.)
library(tidyverse)
library(ratdat)

class(complete_old)
head(complete_old)
tail(complete_old)

head(complete_old, n = 2)
head(complete_old, 2)
# If we switch the order of the arguments, then we *have* to name them.
head(n = 2, x = complete_old)

# Getting help with functions?
?head
summary(complete_old)
str(complete_old)

complete_old$year
complete_old$species

# Assignment, objects, and values
x <- 5
y <- x
x <- 10

x <- 5
sqrt(x/2)

# Reading in data from outside of R
surveys <- read_csv("data/surveys_complete_77_89.csv")

# The "select" function is used to select only a few columns
select(surveys, plot_id, species_id, hindfoot_length)
select(surveys, -record_id, -year)
select(surveys, 10)
select(surveys, where(is.numeric))

# Creating a subset of data
mydata_subset <- select(surveys, plot_id, species_id, hindfoot_length)

# We can use the function "filter" to choose only certain rows.
filter(surveys, year == 1985)
filter(surveys, species_id %in% c("RM", "DO")) #filter the "surveys" dataset to keep only the rows where the value of the 'species_id' column is found in the vector of RM and DO

filter(surveys, year<= 1988 & !is.na(hindfoot_length)) # rows of surveys where the year is less than or equal to 1988 and where hindfoot_length is not NA. 

# Filter to rows where year is before 1980 and sex is only M
males_1980 <- filter(surveys, year>1980 & sex == "M")

#Filter to rows where the genus is "Neotoma" and the plot_type is either "Control" or "Long-term Krat Exclosure"
filter(surveys, genus == "Neotoma", plot_type %in% c("Control", "Long-term Krat Exclosure"))

#Use surveys data to make a data frame that has only data with years from 1980 to 1985

#Use surveys data to make a data frame that only the following columns, in order: year, month, species_id, plot_id
select(surveys, year, month, species_id, plot_id)

# the pipe: %>%
filter(select(surveys, -day), month >=7)

surveys_noday <- select(surveys, -day)
filter (surveys_noday, month >= 7)

surveys %>%
  select(-day) %>%
  filter(month >= 7)
# Take the surveys data set, AND THEN select all but the day column, AND THEN filter rows such that month is >= 7

# Use the surveys data to make a data frame that has the columns record_id, month, and species_id, with data from the year 1988
surveys %>%
  filter(year == 1988) %>%
  select(record_id, month, species_id)

# Grouping and summarizing data by group
# group_by() and summarize()

surveys %>%
  group_by(sex, species) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys %>%
  group_by(sex, species) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE), 
            sample_size = n())%>%
  arrange(desc(mean_weight))
