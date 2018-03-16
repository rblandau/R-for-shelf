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



# and a strong reply from
# https://stackoverflow.com/questions/10349206/add-legend-to-ggplot2-line-plot

You can get the desired effect by (and this also cleans up the original plotting code):

ggplot(data = datos, aes(x = fecha)) +
  geom_line(aes(y = TempMax, colour = "TempMax")) +
  geom_line(aes(y = TempMedia, colour = "TempMedia")) +
  geom_line(aes(y = TempMin, colour = "TempMin")) +
  scale_colour_manual("", 
                      breaks = c("TempMax", "TempMedia", "TempMin"),
                      values = c("red", "green", "blue")) +
  xlab(" ") +
  scale_y_continuous("Temperatura (C)", limits = c(-10,40)) + 
  labs(title="TITULO")

The idea is that each line is given a color by mapping the colour aesthetic to a constant string. Choosing the string which is what you want to appear in the legend is the easiest. The fact that in this case it is the same as the name of the y variable being plotted is not significant; it could be any set of strings. It is very important that this is inside the aes call; you are creating a mapping to this "variable".

scale_colour_manual can now map these strings to the appropriate colors. The result is 