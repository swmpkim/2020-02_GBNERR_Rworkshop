# Notes/live-coding from Day 2  
# also to be filled in as we go  

# bit.ly/gb2020-notes02


library(tidyverse)

# data files from day 1 ----

wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)

wq_trimmed <- wq %>% 
    select(station_code, month, day, temp, sal, do_pct, depth) %>% 
    filter(!is.na(depth))

ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)

ebird <- dplyr::distinct(ebird)
# dates ----
# data frame for dates
date_practice <- tribble(
    ~iso8601, ~mdy, 
    "2018-01-01", "01/01/18", 
    "2018-02-01", "02/01/18", 
    "2018-03-01", "03/01/18" 
)



glimpse(date_practice)
library(lubridate)

class(date_practice$iso8601)
class(ymd(date_practice$iso8601))

date_practice <-date_practice %>%
    mutate(iso8601_asDate = ymd(iso8601),
           mdy_asDate = mdy(mdy))
glimpse(date_practice)


# functions ----

mean(wq_trimmed$temp, na.rm = TRUE)
mean
mutate


# standard error = stdev / sqrt(n)

x <- c(0:10, 50)

sd(x)
length(x)

sterr_x <- sd(x, na.rm = TRUE) / sqrt(length(x))

# if we want to find standard error of
# temp in the wq_trimmed data frame:
x <- wq_trimmed$temp


sterr <- function(x) {
  sd(x, na.rm = TRUE) / sqrt(length(x))
}


sterr2 <- function(temp) {
  sd(temp, na.rm = TRUE) / sqrt(length(temp))
}

sterr(x = wq_trimmed$temp)
sterr(x = wq_trimmed$sal)


a <- 5
b <- 10

aplusb <- function(a, b) {
  a + b
}

aplusb(10, 20)








# data frames for "class" work
bio <- data.frame("Bobby" = c(100, 90, 100, 100, 100),
                  "Joe" = c(90, 90, 80, 90, 90),
                  "Susie" = c(90, 90, 80, 90, 90),
                  "Jill" = c(100, 100, 100, 90, 100))

english <- data.frame("Bobby" = c(90, 90, 80, 80, 90),
                      "Joe" = c(90, 90, 80, 100, 100),
                      "Susie" = c(80, 80, 90, 90, 90),
                      "Jill" = c(80, 90, 100, 90, 100))
