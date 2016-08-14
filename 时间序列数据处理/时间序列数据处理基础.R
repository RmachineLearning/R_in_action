##################################################################
#日期型数据

mydates <- as.Date(c("2007-06-22", "2004-02-13"))

# Converting character values to dates

strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y")

myformat <- "%m/%d/%y"
leadership$date <- as.Date(leadership$date, myformat)
#as.Date只能处理日期时间，用ISOdate 或者ISOdatetime 处理日期和日期时间
ISOdatetime(2012,10,3,7,15,04,tz = 'GMT') #数值型数据
ISOdatetime("2012","10","3","7","15","04",tz = 'GMT')#字符型
mydatetime = data.frame(matrix(c(2012, 2011, 10, 12, 3, 5, 
                                  11,8,20, 30, 10, 15), nrow = 2))
colnames(mydatetime) = c("year", "month", "day",
                         "hour", "minute", "second")

mydatetime$datetime = ISOdatetime(year = mydatetime[,1],
                         month = mydatetime[,2], 
                         day = mydatetime[,3], 
                         hour = mydatetime[,4], 
                         min = mydatetime[,5],
                         sec = mydatetime[,6],
                         tz = 'GMT')
#提取本地时间

Sys.Date()
date()

#时间的输出形式
today <- Sys.Date()
format(today, format = "%B %d %Y")
format(today, format = "%A")

# 时间计算
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2009-06-22")
days <- enddate - startdate

##########################

# Date functions and formatted printing

today <- Sys.Date()
format(today, format = "%B %d %Y")
dob <- as.Date("1956-10-10")
format(dob, format = "%A")

# --Section 4.7--

# Listing 4.5 - Converting from one data type to another

a <- c(1, 2, 3)
a
is.numeric(a)
is.vector(a)
a <- as.character(a)
a
is.numeric(a)
is.vector(a)
is.character(a)

# --Section 4.8--

manager <- c(1, 2, 3, 4, 5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", 
          "5/1/09")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
q1 <- c(5, 3, 3, 3, 2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)

#stringsAsFactors = FALSE字符串不变成因子型
leadership <- data.frame(manager, date, gender, age, 
                         q1, q2, q3, q4, q5, stringsAsFactors = FALSE)

newdata <- leadership[order(age), ]
newdata
detach(leadership)

attach(leadership)
newdata <- leadership[order(gender, -age), ]
newdata
detach(leadership)

# -- Section 4.10--

# Selecting variables

newdata <- leadership[, c(6:10)]

myvars <- c("q1", "q2", "q3", "q4", "q5")
newdata <- leadership[myvars]

myvars <- paste("q", 1:5, sep = "")
newdata <- leadership[myvars]

# Dropping variables

myvars <- names(leadership) %in% c("q3", "q4")
newdata <- leadership[!myvars]

newdata <- leadership[c(-7, -8)]

# You could use the following to delete q3 and q4
# from the leadership dataset (commented out so 
# the rest of the code in this file will work)
#
# leadership$q3 <- leadership$q4 <- NULL

# Selecting observations

# Listing 4.6 - Selecting Observations

newdata <- leadership[1:3, ]

newdata <- leadership[which(leadership$gender == "M" & 
                              leadership$age > 30), ]

attach(leadership)
newdata <- leadership[which(leadership$gender == "M" & 
                              leadership$age > 30), ]
detach(leadership)

# Selecting observations based on dates

leadership$date <- as.Date(leadership$date, "%m/%d/%y")
startdate <- as.Date("2009-01-01")
enddate <- as.Date("2009-10-31")
newdata <- leadership[leadership$date >= startdate & 
                        leadership$date <= enddate, ]

# Using the subset() function

newdata <- subset(leadership, age >= 35 | age < 24, 
                  select = c(q1, q2, q3, q4))
newdata <- subset(leadership, gender == "M" & age > 
                    25, select = gender:q4)

#日期的分组提取
#weekdays() 提取日期所在的工作日
#months() 提取日期变量所在的月份
#quarters() 提取所在的季节
#julian() 提取日期变量离某一天起点的天数
weekdays(startdate) 
months(startdate)
quarters(startdate)
julian(startdate, origin = as.Date("2012-10-3"))

