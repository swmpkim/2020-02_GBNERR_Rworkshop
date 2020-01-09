# This script contains the installation codes for required packages
# used in "Integrating R into your work with RStudio and the tidyverse"
# held at Grand Bay NERR, Feb 19-20, 2020
# ------------------------------------------------------------------

# Select all the code below and click "Run"
reqpackages <- c("tidyverse", "tidyr", "rmarkdown", "knitr",
                 "here", "janitor", "shiny", "ggThemeAssist")

install.packages(reqpackages)
