# R script to set up PreservationSimulation/shelf data
# RBLandau 20141214
# revised 20150619
# revised 20150701 to group by glitch impact (outside).
# revised 20150810 to ignore missing data (NA) values in most calcs.
# revised 20150918 to include more data in datn.
# revised 20160827 to include better header info in file.
# revised 20161006 to print lifem sanely when it has large values.  
# revised 20170302 to narrow copies to 8 instead of 20.
# revised 20170310 to remove summarize function to separate file.
# revised 20170312 to remove the dump-stats, too, to grouping-specific file.
# revised 20170315 to repair some local data references.
# 

# REQUIRES the following to be defined as global strings before invoking
#  this script:
# - sInputFilename
# - sOutputFilename
# - sTitle
# - sSubtitle
# - sSummarizeFilename
# - sAnalyzeFilename
# This is all done in the shelf_call.r script.  Just edit the filenames and
#  title strings, and blast off.  

# f n H e a d i n g I n f o 
# Print a bunch of identifying information at the top of the report.
# Actually, also called to print the same info on the console to 
#  reassure the user that we haven't gone haywire for many seconds.  
fnHeadingInfo <- function(myfilename) 
{
    sMynameIs <- myfilename
    cat(sTitle,"\n")
    cat(sSubtitle,"\n")
    cat("\n")
    cat("Input data from ", sInputFilename, "\n")
    cat("Output analysis into ", sOutputFilename, "\n\n")
    cat("analysis tables by ", sMynameIs, "\n")
    cat("and summarize script", sSummarizeFilename,"\n")
    cat(" at ",format(Sys.time(),"%Y%m%d_%H%M%S %Z"),"\n")
    cat("\n")
}#ENDFN fnHeadingInfo

# F U N C T I O N S 

# W h a t e v e r S a m p l e S a d i s t i c s Y o u W a n t 
# Prints a header line and then all these stats.  
# The header line is anything you want, four pairs of name and value.  
WhateverSampleSadisticsYouWant <- function(p1n,p1,p2n,p2,p3n,p3,p4n,p4,vect)
{
    # for the grouping variables, args include name (p1n) and then value (p1).
    cat("====== ",p1n,p1,p2n,p2,p3n,p3,p4n,p4,"N",length(vect)," ======","\n")
    stem(vect)
    cat(p1n,p1,p2n,p2,p3n,p3,p4n,p4,"N",length(vect),"\n")
    cat("median","\t\t",median(vect,na.rm=TRUE),"\n")
    cat("trimean","\t",trimean(vect),"\n")
    cat("midmean","\t",midmean(vect),"\n")
    stat_mean <- mean(vect,na.rm=TRUE)
    cat("mean","\t\t",stat_mean,"\n")
    cat("stddev","\t\t",sd(vect,na.rm=TRUE),"\n")
    cat("IQR","\t\t",IQR(vect,na.rm=TRUE),"\n")
    cat("mad","\t\t",mad(vect,na.rm=TRUE),"\n")
    stat_SEM <- (sd(vect,na.rm=TRUE)/sqrt(length(vect)))
    cat("SEM","\t\t",stat_SEM,"\n")
    stat_MeanOverSEM <- stat_mean / stat_SEM
    stat_LogMeanOverSEM <- log10(stat_mean / stat_SEM)
    cat("MeanOverSEM","\t",stat_MeanOverSEM,"\n")
    cat("LogMeanOverSEM","\t",stat_LogMeanOverSEM,"\n")
    cat("\n")
}#ENDFN WhateverSampleSadisticsYouWant

# A couple particular functions for summarizing the loss data.
# These might be slightly more robust than just mean, and slightly
#  more broadly estimated than median.  
# trimean was a JWT favorite.  
trimean <-  function(vect)  { foo <- fivenum(vect); ans <- 0.5*foo[3] + 0.25*foo[2] + 0.25*foo[4]; ans }
midmean <-  function(vect)  { ans <- mean(vect,trim=0.25,na.rm=TRUE); ans }

# s u m m a r i z e 
# Summarize function removed to separate file because it is extremely
#  grouping-dependent.  
source(sSummarizeFilename)

# M A I N L I N E  
# Code that executes rather than just defines other functions.  
# There really should not be any top-level executable code outside this routine.  
main <- function(){

    # W H A T ' S   M Y   N A M E 
    # What is the name of this script?
    #  (There ought to be a way to introspect this, a la $0, but I can't find it 
    #  in StackOverflow or Rblogs, rats.)
    sMynameIs <- sAnalyzeFilename   # Dumb, dumb, dumb.

    # I N P U T 
    dat <- data.frame(read.table(sInputFilename, header=TRUE))
    # Use dataset with only the interesting columns: docsize, lifem, glitchimpact, copies, lost
    # because we don't want to aggregate anything else.
    datn <- fnSelectColumns(dat)
    #print(datn)

    # Expose the data so I can at least see them in R Studio for debugging.
    assign("dat", dat, envir=globalenv())
    assign("datn", datn, envir=globalenv())

    # H E A D I N G S 
    # Put out headings immediately to reassure the R user
    fnHeadingInfo(sMynameIs)

    # T A B L E S 
    # Tables function removed to separate file.
    # Establish the table names in this context so they can be used
    #  inside the functions.

    # O U T P U T 
    # Send output to a file so we can read it later. 
    sink(sOutputFilename)
    # Include heading info in file
    fnHeadingInfo(sMynameIs)

    # Show results.
    if(TRUE){
        cat("Summary losses (midmeans)\n")
        summid <- fnTableMid(dat)
        print(summid)
        cat("\n")
    }#ENDIFFALSE

    if(TRUE){
        cat("Summary losses (medians)\n")
        summed <- fnTableMed(dat)
        print(summed)
        cat("\n")
    }#ENDIFFALSE

    if(TRUE){
        cat("Summary losses (trimeans)\n")
        sumtri <- fnTableTri(dat)
        print(sumtri)
        cat("\n")
    }#ENDIFFALSE

    cat("\n")

    if(1){
        # All the grouping and aggregation dependent code has been moved
        #  to a separate file.  
        if (exists("bTablesOnly") & (! bTablesOnly))
        {
            cat("============================================\n")
            # Let's look at the distributions of the samples.  
            fnDetailedSampleStats(datn)
        }
    }#ENDIFFALSE
    
    # Close the output sink manually.  
    # Is there a way to do this automatically so it doesn't linger?
    sink()

}#ENDFN main

#END
