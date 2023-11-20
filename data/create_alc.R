# Sakari Välimäki, 16.11.2023, alcohol consumption data portugal
# data source: https://www.archive.ics.uci.edu/dataset/320/student+performance

# reading the "student-mat.csv" data from the local folder
math <- read.table("data/student-mat.csv", sep = ";" , header = TRUE)

# exploring the structure and dimensions of the data
str(math)
dim(math)

# reading the "student-mat.csv" data from the local folder
por <- read.table("data/student-por.csv", sep = ";" , header = TRUE)

# exploring the structure and dimensions of the data
str(por)
dim(por)

# Joining the data sets.

library(dplyr)
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

str(math_por)
dim(math_por)
glimpse(math_por)

# Removing the duplicates
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}
# Weekday and weekend alcohol use to new column
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

alc <- mutate(alc, high_use = alc_use > 2)

# checking the data
library(tidyverse)
glimpse(alc)

# Saving the joined data
library(readr)
write_csv(alc, file = "data/joined_alc_data.csv")

# seems to be ok
