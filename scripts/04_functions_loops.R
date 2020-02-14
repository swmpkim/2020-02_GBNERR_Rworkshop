# Functions  ----

# load packages
library(dplyr)
library(tidyr)
library(here)
library(ggplot2)


# read in data
ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)
ebird <- dplyr::distinct(ebird)

wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)
wq_trimmed <- wq %>%
    select(station_code, month, day, temp, sal, do_pct, depth) %>%
    filter(!is.na(depth)) %>%
    mutate(depth_ft = depth * 3.28,
           temp_f = (9/5) * temp + 32)



# sterr calculation ----
# (only for temp_f)
sd(wq_trimmed$temp_f, na.rm = TRUE) / sqrt( sum(!is.na(wq_trimmed$temp_f)) )


# generalize a bit  
x <- wq_trimmed$sal
sd(x, na.rm = TRUE) / sqrt( sum(!is.na(x)) )

# now as a function ----
sterr <- function(x){
    sd(x, na.rm = TRUE) / sqrt( sum(!is.na(x)) )
}


# use it!
sterr(wq_trimmed$temp_f)



################################################################################
# Your Turn 1 ----


# YT1 part 1 ----

# Use `group_by`, `summarize`, and our new `sterr` function to 
# generate a table of standard error by month, by station, for `temp_f`. 
# Does the standard error at `gndblwq` for January (month 1) match 
# our output from above? 







# YT1 part 2 ----

# Now **you** write a function! 
# Name it `divide_by_10`. 
# The input should be a vector (like we did with `sterr`), and 
# the output should be each value of that vector divided by 10.  

# Remember to get it working *before* you wrap it up into a function.  







# YT1 part 3 
# Now. What if we want to divide by something other than 10? 
# Generalize the function to take two arguments as input. 
# The second input (call it `y`) should be the denominator 
# in your `divide_by` function.  






################################################################################




# Functions using ggplot ----
my_plot <- function(data, param1, param2, param3) {
    ggplot(data) +
        geom_point(aes(x = {{ param1 }}, 
                       y = {{ param2 }}, 
                       color = {{ param3 }} )) 
}




################################################################################
# Your Turn 2 ----

# Add theme elements to the plot in your `my_plot` function to 
# make it a plot you actually *want* to reproduce. 

# Then use your function on at least TWO combinations of parameters 
# (if you need ideas, we always like `do_pct` vs `temp`, 
# and `do_pct` vs `sal`).  







################################################################################





# Loops ----

# simple example; just printing members of a vector

fruits <- c("apple", "banana", "canteloupe")

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
# and you want to make a separate "`my_plot`" for each station in the datset.    


# First, make a vector of unique `station_code`s in `wq_trimmed` 
# (Hint: look up the function `unique`).

my_stns <- -------


# Now, fill in the skeleton below of a loop to print out `my_plot` for each station.  

for(i in ----(my_stns)){
    wq_sub <- wq_trimmed %>% 
        ------(station_code == my_stns[i])
    
    print(my_plot(wq_sub, sal, do_pct, station_code))
}

################################################################################




# Saving values from loops ----

# create empty or dummy vectors
stns_out <- rep("dummy_value", length(my_stns))
mean_sal_out <- rep(0, length(my_stns))

stns_out; mean_sal_out


# write over the members of the vectors with the loop
for(i in seq_along(my_stns)){
    wq_sub <- wq_trimmed %>% 
        filter(station_code == my_stns[i])
    
    stns_out[i] <- my_stns[i]
    mean_sal_out[i] <- mean(wq_sub$sal, na.rm = TRUE)
}

stns_out; mean_sal_out



################################################################################
# Your Turn 4 ----

# In one loop, calculate mean temperature and mean depth 
# for each station, and print the results. 
# Remember to set up output vectors first!







################################################################################

