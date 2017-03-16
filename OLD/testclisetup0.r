# testclisetup.r
# how to get arguments passed when sourcing an R script

# Use a function?  Icky, but seems to work.
cat("Running testclisetup.r \n")
commandArgs <- function() c("inputfile","outputfile")
source("testcli0.r")


#END
