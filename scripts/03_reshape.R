# Reshaping with tidyr  

# load packages
library(dplyr)
library(tidyr)
library(here)
library(stringr)
library(ggplot2)


# load and clean up some data files we've already been working with
ebird <- read.csv(here::here("data", "eBird_workshop.csv"), stringsAsFactors = FALSE)
ebird <- dplyr::distinct(ebird)

wq <- read.csv(here::here("data", "daily_wq.csv"), stringsAsFactors = FALSE)
wq_trimmed <- wq %>%
    select(station_code, month, day, temp, sal, do_pct, depth) %>%
    filter(!is.na(depth)) %>%
    mutate(depth_ft = depth * 3.28,
           temp_f = (9/5) * temp + 32)



# generate "toy data" to follow along with the slideshow
cases <- tribble(
    ~Country, ~"2011", ~"2012", ~"2013",
    "FR",    7000,    6900,    7000,
    "DE",    5800,    6000,    6200,
    "US",   15000,   14000,   13000
)


pollution <- tribble(
    ~city, ~size, ~amount,
    "New York", "large",      23,
    "New York", "small",      14,
    "London", "large",      22,
    "London", "small",      16,
    "Beijing", "large",     121,
    "Beijing", "small",     121
)








# more data to work with
tox <- read.csv(here::here("data", "C_elegans_tox.csv"), stringsAsFactors = FALSE) 
tox_cleaned <- tox %>% 
    select(1:10)


################################################################################
# YOUR TURN 1 ----
tox_cleaned %>% 
    pivot_longer(cols = starts_with("C.elegans_response"), 
                 names_to = c("org", "what", "conc", "units"),
                 names_sep = "_",
                 values_to = "response") %>% 
    ----(conc = as.numeric(conc))

###

tox_cleaned %>% 
    pivot_longer(cols = starts_with("C.elegans_response"), 
                 names_to = c("org", "what", "conc", "units"),
                 names_sep = "_",
                 values_to = "response") %>% 
    ----(conc = as.numeric(conc)) %>% 
    ggplot(aes(x = conc, y = response)) +
    geom_point() +
    ----(~ Name)

################################################################################