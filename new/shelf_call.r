# Edit me and run me.  (In R Studio, select all, then ctrl-Enter.)

sInputFilename  <- "../hl/data/GiantOutput_af10000s1_ShortLogs_00.txt"
sOutputFilename <- "../hl/tabs/hl_AuditVAR_copvar_shock0_glitch0_lifvar-seed21_analysis_20170316_00.txt"
sTitle <- "HL copies=var Audit=var Glitch=0 Shock=0 lifem=var seedXXX"
sSubtitle <- "(test of summ-audit.r with shortlogs data)"
sSummarizeFilename <- "./summ-audit.r"
sAnalyzeFilename <- "./ShelfAnalyze.r"
bTablesOnly <- 1

source(sAnalyzeFilename)
#trace(fnTables)
#trace(summarize)

main()

# Unwind any remaining sink()s to close output files.  
# Particularly important in case of errors.  
while (sink.number() > 0) {sink()}

