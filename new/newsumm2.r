# try this
foo<-dat
bar<-data.frame(foo$copies,foo$lifem,foo$lost,
                foo$shockfreq,foo$shockimpact,
                foo$shockspan,foo$shockmaxlife)
d0<-bar
datsumm<-data.frame(rbind(numeric(6)))
colnames(datsumm)<-c("span","lifem","cop2","cop3","cop4","cop5")


sVar1 = "shockspan"
sVar2 = "lifem"

groupby2 <- function(sVar1, sVar2, sLabel1, sLabel2)
{

assign(paste0("d0$foo.",sVar1), get(paste0("d0$foo.",sVar1)))
assign(paste0("mine.",sVar1), get(paste0("d0$foo.",sVar1)))



    c1<-d0$foo.shockspan
    f1<-levels(factor(c1))
    for (s1 in f1) {d1<-data.frame(d0[c1==s1,])
      
      c2<-d1$foo.lifem
      f2<-levels(factor(c2))
      for (s2 in f2) {d2<-data.frame(d1[c2==s2,])
          
          tmp11 <- aggregate(d2, by=list(d2$foo.copies), 
            FUN=mean)
          newrow<-c(s1,s2,round(tmp11$foo.lost,1))
          print(newrow)
          datsumm <- rbind(datsumm,as.numeric(newrow))
      }
    }

    datsumm<-datsumm[-1,]
    print(datsumm)
    while (sink.number() > 0) {sink()}





}




if(1){
# now do it in the other order.
datsummrev<-data.frame(rbind(numeric(6)))
colnames(datsummrev)<-c("lifem","span","cop2","cop3","cop4","cop5")

c1<-d0$foo.lifem
f1<-levels(factor(c1))
for (s1 in f1) {d1<-data.frame(d0[c1==s1,])
  
  c2<-d1$foo.shockspan
  f2<-levels(factor(c2))
  for (s2 in f2) {d2<-data.frame(d1[c2==s2,])

    tmp11 <- aggregate(d2, by=list(d2$foo.copies), 
      FUN=mean)
    newrowrev<-c(s1,s2,round(tmp11$foo.lost,1))
    print(newrowrev)
    datsummrev <- rbind(datsummrev,as.numeric(newrowrev))
  }
}

datsummrev<-datsummrev[-1,]
print(datsummrev)
while (sink.number() > 0) {sink()}
}#ENDIFFALSE

sink("tmp.txt")
print(datsumm)
print(datsummrev)
sink()

while (sink.number() > 0) {sink()}


#conclusion 20170321.1345: nope, the aggregation is being done on 
#some other planet.  closer examination required.  the shape is right, 
#though.  
#conclusion 20170321.1620: almost seems to work!  bronze it and try more!

if(0){
# hint from stackoverflow "r string as variable"
eval(parse(text="somestring"))
#that might have been paste0-ed from parts.

# someone said as.name() is useful, too.  haven't tried.  
# i think they meant as.symbol() which goes the other way.
# nope.

# also assign
assign("somestring", somevalue)
# this actually works
assign(paste0("dx$foo.","crud"), d0$foo.lifem)
# might be the answer

# this perverted piece of crap sort of does what i want
name2<-assign("anystring", eval(parse(text= )))

# and get() may avoid the evil eval
levels(factor(get(paste0("d0$foo.","lifem"))))

# and this might help get the labels associated with columns
original_string <- c("x=123", "y=456")
pairs <- strsplit(original_string, "=")
lapply(pairs, function(x) assign(x[1], as.numeric(x[2]), envir = globalenv()))
ls()

# also check this out
#> mydf <- data.frame( g=c('a','b','c') )
#> ID <- 1
#> 
#> mydf[[ sprintf("VAR%02d",ID) ]] <- 1:3
#> mydf
#  g VAR01
#1 a     1
#2 b     2
#3 c     3

obj<-list(a=1,b=2)

# or this pernicious example
x <- as.list(rnorm(10))
names(x) <- paste("a", 1:length(x), sep = "")
list2env(x , envir = .GlobalEnv)



}