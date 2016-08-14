URL    <- "http://rfunction.com/code/1202/BarackObamaTweets.txt"
tweets <- read.delim(URL)
tweets <- as.character(tweets[,1])

these <- grep("[Rr]omney", tweets)
tweets[647]
tweets[703]
tweets[1279]

these

tweets[these]

