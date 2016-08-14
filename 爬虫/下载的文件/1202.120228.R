
library(twitteR)
po <- userTimeline("PLoSONE", n=5)
po[[1]]

rf <- userTimeline("RFunction", n=5)
rf[[1]]

length(rf)
