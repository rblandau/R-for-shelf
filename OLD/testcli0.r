# testcli.r
# how to get arguments passed when sourcing an R script

cat("Running testcli.r \n")
cat("commandArgs(): ")
print(commandArgs())

cat("Individual args:\n")
vect <- commandArgs()
print(vect)
print(vect[1])
print(vect[2])


#END
