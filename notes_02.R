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


# Your Turn 1 ----

# Use `group_by`, `summarize`, and our new `sterr` function to 
# generate a table of standard error by month, by station, for `temp_f`. 

wq_sterr <- wq_trimmed %>% 
    group_by(station_code, month) %>% 
    summarize(mean_temp = mean(temp, na.rm = TRUE),
              sd_temp = sd(temp, na.rm = TRUE),
              se_temp = sterr(temp))

# Now **you** write a function! 
# Name it `divide_by_10`. 
# The input should be a vector (like we did with `sterr`), and 
# the output should be each value of that vector divided by 10.  

# Remember to get it working *before* you wrap it up into a function.  


divide_by_10 <- function(x){
    x / 10
}


# YT1 part 3 
# Now. What if we want to divide by something other than 10? 
# Generalize the function to take two arguments as input. 
# The second input (call it `y`) should be the denominator 
# in your `divide_by` function. 


divide_by <- function(x, y){
    x / y
}

# set default values when defining arguments
divide_by2 <- function(x, y = 10){
    x / y
}


# functions involving graphs ----
ggplot(data = wq_trimmed) +
    geom_point(aes(x = temp, y = do_pct, color = station_code)) +
    labs(title = "DO by temp")


# embrace the arguments {{ }}
# a version where you have to provide a title
# as a character string
pretty_plot <- function(data, x, y, color, title) {
  ggplot(data = data) +
      geom_point(aes(x = {{ x }}, 
                     y = {{ y }}, 
                     color = {{ color }})) +
      labs(title = title)
}

# example
pretty_plot(data = wq_trimmed, 
            x = sal, 
            y = temp, 
            color = station_code, 
            title = "Temperature by Salinity")



# this version does *not* make a title
# but you can add it in after
pretty_plot2 <- function(data, x, y, color) {
    ggplot(data = data) +
        geom_point(aes(x = {{ x }}, 
                       y = {{ y }}, 
                       color = {{ color }}
                       )
        )
}

# example
pretty_plot2(data = wq_trimmed, 
             x = sal, 
             y = temp, 
             color = station_code)

# with title
pretty_plot2(data = wq_trimmed, 
            x = sal, 
            y = temp, 
            color = station_code) +
    labs(title = "Temp by Salinity")




# Loops ----

# for each ____ in some group ____, do something

# simple example; just printing members of a vector

fruits <- c("apple", "banana", "canteloupe")

length(fruits)
class(fruits)

for(i in 1:length(fruits)){
    print(fruits[i])
}


# another, safer way
for(i in seq_along(fruits)){
    print(fruits[i])
}



################################################################################
# Your Turn 3 ----

# Imagine you've never heard of `ggplot2`'s `facet` capabilities, 
# and you want to make a separate "`pretty_plot`" for each station in the datset.    


# First, make a vector of unique `station_code`s in `wq_trimmed` 
# (Hint: look up the function `unique`).

my_stns <- unique(wq_trimmed$station_code)
    
    
    # Now, fill in the skeleton below of a loop to print out `my_plot` for each station.  
    
    for(i in seq_along(my_stns)){
        wq_sub <- wq_trimmed %>% 
            filter(station_code == my_stns[i])
        
        print(pretty_plot2(wq_sub, sal, do_pct, station_code))
    }


# if you hate loops, check out:
# purrr package
# apply/lapply/tapply/sapply functions in base R










# data frames for "class" work
bio <- data.frame("Bobby" = c(100, 90, 100, 100, 100),
                  "Joe" = c(90, 90, 80, 90, 90),
                  "Susie" = c(90, 90, 80, 90, 90),
                  "Jill" = c(100, 100, 100, 90, 100))

english <- data.frame("Bobby" = c(90, 90, 80, 80, 90),
                      "Joe" = c(90, 90, 80, 100, 100),
                      "Susie" = c(80, 80, 90, 90, 90),
                      "Jill" = c(80, 90, 100, 90, 100))
