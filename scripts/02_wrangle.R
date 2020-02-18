library(dplyr)
library(tidyr)
library(lubridate)
library(here)
library(ggplot2)

# daily water quality values
wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)
glimpse(wq)



# EBIRD DATASET
ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)
glimpse(ebird)   # 183,742 rows

# look for duplicate rows
janitor::get_dupes(ebird)   # 22 duplicates = 11 that need to go
# if they're exact duplicates (we know they are), get rid of them:
ebird <- dplyr::distinct(ebird)
glimpse(ebird)   # 183,731 rows