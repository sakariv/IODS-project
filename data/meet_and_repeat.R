# Sakari Välimäki
# 06122023
# original data 
# BPRS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# RATS: https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

library(readr)
library(dplyr)

# reading the BPRS data
BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", header = T, sep = " ") # separator space

# exploring the BPRS data
colnames(BPRS)
dim(BPRS)
str(BPRS)

# reading the RATS data
RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T, sep = '\t') # separator tab

# exploring the rats data
colnames(RATS)
dim(RATS)
str(RATS)

# Now that the separator is right the datasets seem ok

# Converting the categorical variables to factors:
# BPRS:
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
# RATS:
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Converting to long form and adding week variable to BPRS and Time variable to RATS:
# BPRS:
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
# RATS: 
RATSL <- pivot_longer(RATS, cols=-c(ID,Group), names_to = "WD",values_to = "Weight")  %>%  mutate(Time = as.integer(substr(WD,3,4))) %>% arrange(Time)

# Taking a serious look:
# BPRS datasets
dim(BPRS)
dim(BPRSL)
str(BPRS)
str(BPRSL)
colnames(BPRS)
colnames(BPRSL)

# Rats datasets
dim(RATS)
dim(RATSL)
str(RATS)
str(RATSL)
colnames(RATS)
colnames(RATSL)
# in the long form datasets the measurements at different time points have been moved to a single column, instead of each time of observation being in its own column

# Writing the data
write.csv(BPRSL, file = "data/bprsl.csv")
write.csv(RATSL, file = "data/ratsl.csv")
