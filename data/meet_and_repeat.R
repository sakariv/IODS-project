# Sakari Välimäki
# 06122023
# original data 
# BPRS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# RATS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

# Necessary libraries:

library(readr)
library(dplyr)
library(tidyr)

# RATS data

# reading the RATS data
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T, sep = '\t') # separator tab

# exploring the rats data

glimpse(RATS) # all variables are integer

# Converting the categorical variables into factors
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

glimpse(RATS) # now they are factors

# Converting to long form and adding Time variable to RATS:
RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

# Taking a look:

glimpse(RATSL)

# Writing the data into file
write.csv(RATSL, file = "data/ratsl.csv", row.names = FALSE)

glimpse(RATSL)

RATSL <- read.csv("data/ratsl.csv")

glimpse(RATSL)

# BPRS data

# reading the BPRS data
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T, sep = " ") # separator space

# exploring the BPRS data
glimpse(BPRS)

# Converting the categorical variables to factors:
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Converting to long form and adding week variable to BPRS

BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Taking a  look:

glimpse(BPRSL)

# Looks ok

# Writing the data
write.csv(BPRSL, file = "data/bprsl.csv", row.names = FALSE)

# in the long form datasets the measurements at different time points have been moved to a single column, instead of each time of observation being in its own column
