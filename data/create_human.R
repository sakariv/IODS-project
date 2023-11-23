# Sakari Välimäki 23112023
# Data for assignment 5

# reading the data from the internet
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# exploring the 'hd' dataset
str(hd)
dim(hd)
summary(hd)

# exploring the 'gii' dataset
str(gii)
dim(gii)
summary(gii)

# renaming the variables in 'hd'

# to use pipe load dplyr
library(dplyr)

hd <- hd %>% 
  rename(
    hdi_rank = 'HDI Rank',
    country = 'Country',
    hdi = 'Human Development Index (HDI)',
    life.exp = 'Life Expectancy at Birth',
    edu.exp = 'Expected Years of Education',
    edu.mean = 'Mean Years of Education',
    gni_cap = 'Gross National Income (GNI) per Capita',
    gni_cap_hdi = 'GNI per Capita Rank Minus HDI Rank' 
  )
# checking that things look ok

summary(hd)

# renaming the variables in 'hd'

gii <- gii %>% 
  rename(
    gii_rank = 'GII Rank',
    country = 'Country',
    gii = 'Gender Inequality Index (GII)',
    mat.mor = 'Maternal Mortality Ratio',
    ado.birth = 'Adolescent Birth Rate',
    parli.f = 'Percent Representation in Parliament',
    edu2.f = 'Population with Secondary Education (Female)',
    edu2.m = 'Population with Secondary Education (Male)',
    labo.f = 'Labour Force Participation Rate (Female)',
    labo.m = 'Labour Force Participation Rate (Male)'
    )

# checking that things look ok

summary(gii)

# generating two new columns into 'gii' with edu2.f/edu2.m and labo.f/labo.m

gii <- gii %>%
  mutate(
    edu2.fm = edu2.f / edu2.m,
    labo.fm = labo.f / labo.m
  )

# checking that things look ok
summary(gii)
dim(gii)

# joining the two data as one dataset with 'country' as the identifier, with dropping the countries that are not present in both datasets

human <- inner_join(hd, gii, by = 'country', unmatched = "drop")

# checking that data has the correct dimensions
dim(human)

# checking that it looks ok
summary(human)

#writing the data 
write.csv(human, "human.csv")