################ INSTRUCTIONS ##################################

### Use Ctrl+A (Windows) / Cmd+A (Mac)   to select this entire script
### Then Ctrl+Enter / Cmd+Enter  to run it

### Then check the output in your console and see if you 
### need to re-install any packages

### If you do, I recommend trying one at a time, using the command
### install.packages("package_name_here")

### Then re-run this script to make sure everything worked

################################################################


# list of packages we need to have installed for our workflow
reqpackages <- c("tidyverse", "tidyr", "rmarkdown", "knitr",
                 "here", "janitor", "shiny", "ggThemeAssist")

# Kim to-dos: 
# check version of tidyr


## now try loading each one and see if it works
# set up an output vector
pkg_result <- vector("logical", length(reqpackages))
# loop through the needed packages
for(i in seq_along(reqpackages)){
        # try to load the package and report whether it works
        # record that TRUE or FALSE in the pkg_result vector
        pkg_result[i] <- library(reqpackages[i], character.only = TRUE, quietly = TRUE, logical.return = TRUE)
}


# make a vector of missing packages:
# pkgs_needed that failed to load
pkgs_missing <- reqpackages[!pkg_result]


# print the results to the console
if(length(pkgs_missing) == 0){
        message("\n \nAll required packages are installed and loading properly! \n \n")
} else{ message("\n \nYou need to install the following packages: "); cat(pkgs_missing, sep="\n") }
