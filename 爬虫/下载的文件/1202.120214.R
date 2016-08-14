
x <- "Split the words in a sentence."
strsplit(x, " ")

x <- "Split at every character."
strsplit(x, "")

x <- " Split at each space with a preceding character."
strsplit(x, ". ")

x <- "Do you wish you were Mr. Jones?"
strsplit(x, ". ")
strsplit(x, ". ", fixed=TRUE)

#=====> Splitting Dates <=====#
dates <- c("1999-05-23", "2001-12-30", "2004-12-17")
temp  <- strsplit(dates, "-")
temp
matrix(unlist(temp), ncol=3, byrow=TRUE)

#=====> Cofounders of Google and Twitter <=====#
Names <- c("Brin, Sergey", "Page, Larry",
           "Dorsey, Jack", "Glass, Noah",
           "Williams, Evan", "Stone, Biz")
Cofounded <- rep(c("Google", "Twitter"), c(2,4))
temp <- strsplit(Names, ", ")
temp
mat  <- matrix(unlist(temp), ncol=2, byrow=TRUE)
df   <- as.data.frame(mat)
df   <- cbind(df, Cofounded)
colnames(df) <- c("Last", "First", "Cofounded")
df
