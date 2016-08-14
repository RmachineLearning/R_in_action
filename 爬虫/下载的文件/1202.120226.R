
#=====> Simple Dates <=====#
x <- c("2006-07-19", "2006-07-20", "2006-07-21",
       "2006-07-22", "2006-07-23")
d <- as.Date(x) # format="%Y-%m-%d"
d

diff(d)


#=====> Abbreviated Years <=====#
x <- c("06-07-19", "06-07-20", "06-07-21",
       "06-07-22", "06-07-23")
d <- as.Date(x, format="%y-%m-%d")
d

diff(d)


#=====> Dates With Times <=====#
x <- c("06-07-19, 5:12am", "06-07-20, 5:15am",
       "06-07-21, 5:18pm", "06-07-22, 5:22am",
       "06-07-23, 5:25am")
d <- strptime(x, format="%y-%m-%d, %I:%M%p")
d

diff(d)


# Date/Time Formatting Options
?strptime


