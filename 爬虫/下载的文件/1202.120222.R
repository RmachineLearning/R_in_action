
# install.packages("RCurl")
library(RCurl)

# Ebay search: big bang theory season 4
URL  <- "http://www.ebay.com/ctg/Big-Bang-Theory-Complete-Fourth-Season-DVD-2011-3-Disc-Set-/103149230?LH_Auction=1&_dmpt=US_DVD_HD_DVD_Blu_ray&_pcategid=617&_pcatid=1&_refkw=big+bang+theory+season+4&_trkparms=65%253A12%257C66%253A4%257C39%253A1%257C72%253A5841&_trksid=p3286.c0.m14"
html <- getURLContent(URL)
hold <- strsplit(html, "vip")[[1]]
titles <- rep(NA, length(hold)-1)
IDs    <- rep(NA, length(hold)-1)
for(i in 2:length(hold)){
  t1  <- strsplit(hold[i-1], "href=\"")[[1]]
  t2  <- tail(t1, 1)
  t3  <- regexpr("[0-9]{12}", t2)
  t4  <- t3 + attr(t3, "match.length")-1
  t5  <- substr(t2, t3, t4)
  IDs[i-1]    <- as.numeric(t5)
  titles[i-1] <- strsplit(hold[i], '"')[[1]][3]
}
length(titles)
length(IDs)

titles[15:20]

IDs
