# Notes/live-coding from Day 2  
# also to be filled in as we go  


library(tidyverse)

# data files from day 1 ----

wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)

wq_trimmed <- wq %>% 
    select(station_code, month, day, temp, sal, do_pct, depth) %>% 
    filter(!is.na(depth))

ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)

ebird <- dplyr::distinct(ebird)

# data frame for dates
date_practice <- tribble(
    ~iso8601, ~mdy, 
    "2018-01-01", "01/01/18", 
    "2018-02-01", "02/01/18", 
    "2018-03-01", "03/01/18" 
)

# data frames for "class" work
bio <- data.frame("Bobby" = c(100, 90, 100, 100, 100),
                  "Joe" = c(90, 90, 80, 90, 90),
                  "Susie" = c(90, 90, 80, 90, 90),
                  "Jill" = c(100, 100, 100, 90, 100))

english <- data.frame("Bobby" = c(90, 90, 80, 80, 90),
                      "Joe" = c(90, 90, 80, 100, 100),
                      "Susie" = c(80, 80, 90, 90, 90),
                      "Jill" = c(80, 90, 100, 90, 100))
