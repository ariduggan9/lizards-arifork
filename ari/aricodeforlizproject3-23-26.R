# Ari script for lizards with lots of help from analysis_example.R* script
# from Sabrina.

install.packages("brms")

library(lme4) # for standard modeling
library(lmerTest) # for standard modeling
library(ggplot2) # for plots
library(brms) # for mcmc models including relatedness matrix
library(dplyr) # for data wrangling

# Read in data ------------------------------------------------------------
# This is the "master" spreadsheet, each row is a sample, includes Lat Long info.
# Reformate date and sample so that they work as intended
samples <- read.csv("data_analysis/local_dat.csv") %>%
  select(-X) %>%
  rename_with(tolower) %>%
  mutate(species = as.factor(species)) %>%
  mutate(date = as.Date(date, format = "%m/%d/%y")) # make sure date is read in correctly.

# This is the csv from Anthony listing the sexual system for each species and some other covars
sexual_system <- read.csv("data_analysis/sexual_system_info.csv") %>%
  select(-X) %>%
  rename_with(tolower)

# For now just keep species we have info for (including in the relatedness matrix)
samples <- samples %>% filter(species %in% sexual_system$species)

# Call in actual data spreadsheet
library(readxl)
lizdatafixed <- read_excel("C:/Users/DUGGA/OneDrive/Desktop/Ari/McNew_WhiptailExtractions (2) (4).xlsx")
View(lizdatafixed)

# Change specimen number column to match samples sheet
colnames(lizdatafixed)[1] <- "specimen.number"

# Add samples, spreadsheet, and sexual_system data
samples <- left_join(samples, sexual_system)
samples <- left_join(samples, lizdatafixed)

# Data vis with sexual vs unisexual
ggplot(samples %>% group_by(ReproductionStrategy) %>% summarise(pos_rate = mean(actualparasite)),
       aes(ReproductionStrategy, pos_rate)) +
  geom_col()


