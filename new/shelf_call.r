# shelf_call.r
# Edit me and run me.  
# In R Studio, 
# - edit the filenames and title strings below, then 
# - save the file (ctrl-S), 
# - select all (ctrl-A), and 
# - execute the script (ctrl-Enter).

sInputFilename  <- "../hl/data/test/big-q3-afvar.txt"
sOutputFilename <- "../hl/tabs/test2a_q3_combined_AuditVar_copvar_shock0_glitch0_lifvar-seed21_analysis_20170316_00.txt"
sTitle <- "test2a Q3-NOT-HL copies=var Audit=var Glitch=0 Shock=0 lifem=var seedXXX"
sSubtitle <- "(test of summ-audit-test2.r with no lifem column head hack)"
sSummarizeFilename <- "./summ-audit-test2.r"
sAnalyzeFilename <- "./ShelfAnalyze.r"
bTablesOnly <- 0

source(sAnalyzeFilename)
main()
# Unwind any remaining sink()s to close output files.  
# Particularly important in case of errors.  
while (sink.number() > 0) {sink()}

#END
