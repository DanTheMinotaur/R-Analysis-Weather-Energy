# Title     : TODO
# Objective : TODO
# Created by: daniel
# Created on: 13/04/2019

# Function takes vector of packages and installs them if not otherwise just includes them
check.packages <- function(Package){
    new.pkg <- Package[!(Package %in% installed.packages()[, "Package"])]
    if (length(new.pkg))
        install.packages(new.pkg, dependencies = TRUE)
    sapply(Package, require, character.only = TRUE)
}