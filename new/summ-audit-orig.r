# R script to summarize PreservationSimulation/shelf data
# All the grouping and aggregation dependent code should go in here.
#  And there will be one of these files for various combinations of 
#  grouping and aggregation.
# 
# 20141214 RBLandau original version.
# . . . revised many times . . . 
# 20170310  RBL Extract summarize function from larger script.
# 20170312  RBL Also extract table calcs and detailed stats printer.  
# 20170316  RBL Produce this new audit-only version from old 
#                docsize-glitchimpact one.
# 

# f n S e l e c t C o l u m n s 
# What data items are we going to be analyzing by grouping and aggregation?
# Return a new data frame containing only those.  They will be used in 
#  all the summarization and detailed stats functions below.
fnSelectColumns <- function(dat)
{
    datn <- data.frame(dat$auditfrequency,dat$auditsegments,dat$lifem,dat$copies,dat$lost)
    return(datn)
}

# s u m m a r i z e 
# There will be different version of this function for each of 
#  several sets of groupings.
#  This one is glitch-docsize.
#
summarize <- function(myframe,mysummaryout,mysummaryfunction)
{
    # NOTE: colnames and newrow declarations must be in the same order.
    colnames(mysummaryout) <- c("auditfreq","auditseg","lifem","c1","c2","c3","c4","c5","c8")

    for (af in levels(factor(myframe$dat.auditfrequency)))
    {
        tmp1 <- data.frame(myframe[myframe$dat.auditfrequency==af,]);
        for (as in levels(factor(tmp1$dat.auditsegments)))
        {
            tmp2 <- data.frame(tmp1[tmp1$dat.auditsegments==as,]);
            for (lfm in levels(factor(tmp2$dat.lifem))) 
            {
                tmp3 <- tmp2[tmp2$dat.lifem==lfm,]
                tmp4 <- aggregate(tmp3, by=list(tmp3$dat.copies), FUN=mysummaryfunction)
                # NOTE: The columns will print in this order.
                newrow <- c(af,as,lfm,round(tmp4$dat.lost,2))
                
                if (length(newrow) < length(colnames(mysummaryout)))
                {
                    filler <- rep(0,length(colnames(mysummaryout)) - length(newrow))
                    #print(c(length(filler),"=>",filler))
                    #print(c(length(newrow),"=>",newrow))
                    newrow <- c(newrow,filler)
                }
                #print(newrow)
                
                # Absurd hack in here to make lifem print reasonably.
                #  Increase the penalty for printing in scientific 
                #  (exponential) format, and limit the number of digits
                #  so that there are no places after the radix point.  
                # BEWARE of column order dependency here!!!
                colnames(mysummaryout)[3] <- "   lifem"
                options("scipen"=100, "digits"=1)
                # End of absurd hack.  
                mysummaryout <- rbind(mysummaryout,as.numeric(newrow))
            }
        }
    }
    mysummaryout <- mysummaryout[-1,]
    rownames(mysummaryout) <- NULL
    rownames(mysummaryout, do.NULL = TRUE, prefix = "row")
    return(mysummaryout)
}#ENDFN summarize


# T A B L E S 

# f n T a b l e M i d 
fnTableMid <- function(dat)
{
    if(TRUE){
        # Summary table with midmeans.
        xsummid <- data.frame(rbind(numeric(9)))
        dat2 <- fnSelectColumns(dat)
        datn <- dat2[dat2$dat.copies<=8,]
        tsummid <- summarize(datn,xsummid,midmean)
        return(tsummid)
    }#ENDIFFALSE
}#ENDFN fnTableMid

# f n T a b l e M e d 
fnTableMed <- function(dat)
{
    if(1){
        # Summary table with medians.
        xsummed <- data.frame(rbind(numeric(9)))
        dat2 <- fnSelectColumns(dat)
        datn <- dat2[dat2$dat.copies<=8,]
        tsummed <- summarize(datn,xsummed,median)
        return(tsummed)
    }#ENDIFFALSE
}#ENDFN fnTableMed

# f n T a b l e T r i 
fnTableTri <- function(dat){
    if(1){
        # Summary table with trimeans.
        xsumtri <- data.frame(rbind(numeric(9)))
        dat2 <- fnSelectColumns(dat)
        datn <- dat2[dat2$dat.copies<=8,]
        tsumtri <- summarize(datn,xsumtri,trimean)
        return(tsumtri)
    }#ENDIFFALSE
}#ENDFN fnTableTri

# f n D e t a i l e d S a m p l e S t a t s 
fnDetailedSampleStats <- function(datn)
{
    # The order of nesting here makes some comparisons easier than others.  
    for (af in levels(factor(datn$dat.auditfrequency)))
    {
        tmp1 <- data.frame(datn[datn$dat.auditfrequency==af,]);
        for (lfm in levels(factor(tmp1$dat.lifem))) 
        {
            tmp2 <- tmp1[tmp1$dat.lifem==lfm,]
            for (cp in levels(factor(tmp2$dat.copies)))
            {
                tmp3 <- tmp2[tmp2$dat.copies==cp,]
                for (as in levels(factor(tmp3$dat.auditsegments)))
                {
                    tmp4 <- tmp3[tmp3$dat.auditsegments==as,]
                    WhateverSampleSadisticsYouWant("lifem",lfm,"copies",cp,"auditfreq",af,"auditseg",as,tmp4$dat.lost)
                }
            }
        }
    }
}#ENDFN fnDetailedSampleStats


#END
