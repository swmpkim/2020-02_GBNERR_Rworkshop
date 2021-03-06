# Notes/live coding from Day 1  

# to be filled in as we go  


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


your_turn_2 <- ebird %>% 
    filter(state %in% c("FL", "AL", "MS"),
           species == "American Coot") %>% 
    select(state, year, presence)
head(your_turn_2)

# this will cause an error
ebird %>% 
    select(state, year, presence) %>% 
    filter(state %in% c("FL", "AL", "MS"),
           species == "American Coot")



# your turn 3 ----

wq_trimmed <- wq %>% 
    select(station_code, month, day, temp, sal, do_pct, depth) %>% 
    filter(!is.na(depth))


summary(wq$depth)
mean(wq$depth)
mean(wq$depth, na.rm = TRUE)

test <- c(1, 2, 3, 4, 5)
test2 <- c(1, 2, NA, 4, 5)

is.na(test)
is.na(test2)
is.na(wq$depth)

!is.na(wq$depth)


# create new column named depth_ft
wq_trimmed2 <- wq_trimmed %>% 
    mutate(depth_ft = depth * 3.28)
head(wq_trimmed2)

# modify existing depth column
wq_trimmed3 <- wq_trimmed %>% 
    mutate(depth = depth * 3.28)
head(wq_trimmed3)


wq_trimmed <- wq_trimmed %>% 
    mutate(depth_ft = depth * 3.28)


wq_trimmed <- wq_trimmed %>% 
    mutate(monthday = paste(month, day, sep = "-"), 
           meaningless = sal + temp, 
           even_more_meaningless = meaningless + 5)

# to remove objects from your environment,
# use rm(object_to_remove)

# to remove columns from a data frame, 
# use select(-column_to_remove)
wq_trimmed <- wq_trimmed %>% 
    select(-monthday, 
           -meaningless, 
           -even_more_meaningless) %>% 
    mutate(temp_f = (9/5)*temp + 32)


# group by and summarize ---- 

# one level: state
# should result in 50 rows
# (one for each state)
ebird_grouped <- ebird %>%
    group_by(state) %>%
    summarize(mean_presence = mean(presence, na.rm = TRUE),
              max_presence = max(presence, na.rm = TRUE)
    )

# can group on multiple levels
ebird_grouped <- ebird %>%
    group_by(state, species) %>%
    summarize(mean_presence = mean(presence, na.rm = TRUE),
              max_presence = max(presence, na.rm = TRUE)
    )



wq_trimmed %>% 
    group_by(station_code) %>% 
    summarize(mean_depth = mean(depth, na.rm = TRUE))


test <- c(1, 2, 3, 4, 5)
mean(test)
sd(test)



wq_summary <- wq_trimmed %>% 
    group_by(station_code, month) %>% 
    summarize(mean_temp = mean(temp, na.rm = TRUE),
              sd_temp = sd(temp, na.rm = TRUE),
              mean_sal = mean(sal, na.rm = TRUE),
              sd_sal = sd(sal, na.rm = TRUE))



# WHEN YOU GET BACK FROM BREAK
# please copy the code below from the notes page
# or just type it into your script window

# pivoting ----
fish <- read.csv(here::here("data", "guana_fish.csv"),
                 stringsAsFactors = FALSE)

# subset it
fish_sub <- fish %>% 
    select(Date,
           Site,
           Diel,
           starts_with("Cteno"),
           contains("penaeus"))

fish_long <- fish_sub %>% 
    pivot_longer(4:8, names_to = "species",
                 values_to = "count")

ggplot(fish_long) +
    geom_col(mapping = aes(x = species, y = count, fill = species)) +
    facet_wrap(~ Site) +
    theme(axis.text = element_text(angle = 90))

# skipping a step.
fish_sub %>% 
    pivot_longer(4:8, names_to = "species",
                 values_to = "count") %>%
    ggplot() +
        geom_col(mapping = aes(x = species, y = count, fill = species)) +
        facet_wrap(~ Site) +
        theme(axis.text = element_text(angle = 90))

bit.ly/finalchallenge_day1