# Notes/live coding from Day 1  

# to be filled in as we go  
library(tidyverse)

library(tidyverse)
# 02_wrangling section ----
wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)

ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)

ebird <- dplyr::distinct(ebird)

#filter ----

ebird2008 <- ebird %>%
    filter(year == 2008)

ebirdAK <- ebird %>%
    filter(state == "AK")

ebirdAK2008 <- ebird %>%
    filter(state == "AK",
           year == 2008)

ebirdMS2018 <- ebird %>%
    filter(year == 2018,
           state == "MS")

ebirdMSandAK <- ebird %>%
    filter(state %in% c("AK", "MS"))


my_states <- c("AK", "MS")
ebird_again <- ebird %>%
    filter(state %in% my_states)


ebird %>%
    filter(year < 2010,
           state == "AK")

your_turn_1 <- ebird %>%
    filter(species == "American Coot",
           year != 2010,
           state %in% c("MS", "FL"))
    
    
# DON'T do this:
your_turn_1b <- ebird %>%
    filter(species == "American Coot",
           year != 2010,
           state == c("MS", "FL"))

    
# select ----

ebird_select1 <- ebird %>%
    select(species, state)

ebird_select2 <- ebird %>%
    select(state, species)

ebird_select3 <- ebird %>%
    select(-samplesize, -presence)

head(ebird_select3)

ebird_select4 <- ebird %>%
    select(state, year, species, samplesize, presence)

head(ebird_select4)

ebird_select5 <- ebird %>%
    select(year, everything())
head(ebird_select5)
