foo<-dat[dat$seed==919028296,]
# just to shorten things, but could use 
foo<-dat

# this is right
bar<-data.frame(foo$copies,foo$lifem,foo$lost,
    foo$shockfreq,foo$shockimpact,
    foo$shockspan,foo$shockmaxlife)

c1<-bar$foo.shockfreq
f1<-levels(factor(c1))
for (s1 in f1) {d1<-data.frame(bar[bar$foo.shockfreq==s1,])}
# gets all rows with the last value in f1 (= 30000 hrs)

c2<-bar$foo.copies
f2<-levels(factor(c2))
for (s2 in f2) {d2<-data.frame(d1[bar$foo.copies==s2,])}
# gets all rows with the last value in f2 (= 5 copies)

# gack, this actually works
for (s2 in f2) {d2<-data.frame(d1[c2==s2,])}
# that's almost what i was looking for.

c1<-bar$foo.shockspan
f1<-levels(factor(c1))
for (s1 in f1) {d1<-data.frame(bar[bar$foo.shockspan==s1,])}


# try this
foo<-dat
bar<-data.frame(foo$copies,foo$lifem,foo$lost,
    foo$shockfreq,foo$shockimpact,
    foo$shockspan,foo$shockmaxlife)

c1<-bar$foo.shockspan
f1<-levels(factor(c1))
for (s1 in f1) {d1<-data.frame(bar[c1==s1,])

    c2<-bar$foo.copies
    f2<-levels(factor(c2))
    for (s2 in f2) {d2<-data.frame(d1[c2==s2,])

        sink("tmp.txt")
        newrow<-c(s1,s2,d2$foo.lost)
        colnames(newrow)<-c("span","copies","lost")
        print(newrow)
        sink()
    }
}
