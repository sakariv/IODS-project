# Sakari Välimäki, 16.11.2023, alcohol consumption data portugal
# data source: https://www.archive.ics.uci.edu/dataset/320/student+performance

#reading the "student-mat.csv" data from the local folder
math <- read.table("data/student-mat.csv", sep = ";" , header = TRUE)

#exploring the structure and dimensions of the data
str(math)
dim(math)

#reading the "student-mat.csv" data from the local folder
port <- read.table("data/student-por.csv", sep = ";" , header = TRUE)

#exploring the structure and dimensions of the data
str(port)
dim(port)

#Joining the data sets

library(dplyr)
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(port), free_cols)
math_port <- inner_join(math, port, by = join_cols, suffix = c(".math", ".port"))

str(math_port)
dim(math_port)
glimpse(math_port)

#Removing the duplicates
