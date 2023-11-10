# Sakari Välimäki, 6.11.2023, Assignment 2 data wrangling for analysis

# The original data:
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# The learning14 dataset contains integer and character variables
str(lrn14)
# The learning14 dataset contains 183 observations and 60 variables.
dim(lrn14)

# Scaling the data by dividing it with the number of questions
lrn14$attitude <- lrn14$Attitude / 10

# Access the dplyr library
library(dplyr)

# Selection and scaling of the combination variables:
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

# filtering out the observations where points variable = 0
learning2014 <- filter(lrn14, Points > 0)

# selecting the variables for learning2014 dataset
learning2014 <- learning2014[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

# the structure of the data
str(learning2014)

# number of observations and variables
dim(learning2014)

# saving the data as .csv
library(readr)
write_csv(x = learning2014, "data/learning2014.csv")
learningdata2014 <- read_csv("data/learning2014.csv")

# ensuring the data appears correct
str(learningdata2014)
head(learningdata2014)