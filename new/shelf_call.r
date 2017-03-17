# shelf_call.r
# Edit me and run me.  
# In R Studio, 
# - edit the filenames and title strings below, then 
# - save the file (ctrl-S), 
# - select all (ctrl-A), and 
# - execute the script (ctrl-Enter).

sInputFilename  <- "../hl/data/GiantOutput_test_cvar_lifvar_shvar_af10000s1_01.txt"
sOutputFilename <- "../hl/tabs/shocktest_Giant_AuditYr_copvar_shockvar_glitch0_lifvar-seed21_analysis_20170317_01.txt"
sTitle <- "shocktest01 ShockTest HL copies=var Audit=yr Glitch=0 Shock=var lifem=var seed21"
sSubtitle <- "(test of summ-shock.r)"
sSummarizeFilename <- "./summ-shock.r"
sAnalyzeFilename <- "./ShelfAnalyze.r"
bTablesOnly <- 1
options(max.print=9999)
options(width=100)

source(sAnalyzeFilename)
main()
# Unwind any remaining sink()s to close output files.  
# Particularly important in case of errors.  
while (sink.number() > 0) {sink()}

#END
