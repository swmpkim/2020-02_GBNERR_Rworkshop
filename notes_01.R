# Notes/live coding from Day 1  

# to be filled in as we go  



# for 02_wrangling section:
wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)
ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)
ebird <- dplyr::distinct(ebird)