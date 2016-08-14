###################################################
### 从mysql数据库读取数据
###################################################
#R中有两种方式和数据库进行通信
#第一种是基于ODBC协议 要用到RODBC包
#R连接MySQL数据库最简单的方法是通过ODBC(开放数据库互连)协议连接

library(RODBC)
#用odbcConnect()函数建立与数据库的连接
#在运用odbcConnect()之前，在windows下要下载mySQL ODBC驱动程序，创建一个新的用户数据源
#用户数据源驱动的名称是QuotesDSN,
#uid是数据库服务器地址，本机用户是root， 远程主机则是形如mysqlserver.xpto.pt
#pwd是数据库密码
#ch <- odbcConnect("QuotesDSN",uid="myusername",pwd="mypassword")
#这里的数据源驱动名称为mysql5.6_data，指定的数据库的库名是shujuku，
#sp500.sql就是在shujuku这个库中，该库中的表名为gspc
ch <- odbcConnect("mysql5.6_data",uid="root",pwd="123")
allQuotes <- sqlFetch(ch,"gspc")
GSPC <- xts(allQuotes[,-1],order.by=as.Date(allQuotes[,1]))
head(GSPC)
#关闭数据库的连接
odbcClose(ch)


#第二种是基于DBI包提供的通用接口和每个数据库管理系统(DBMS)专用的包
#DBI 系列 (ROracle, RMySQL, RPostgreSQL, RSQLite)
#这里基于DBI包实现了一系列的数据库接口函数，这些函数独立于实际
#上存储数据的的数据库服务器，只需要在最初和数据库建立连接时指出
#用户将应用哪一个通信接口，当改变数据库时，指出希望通信的数据库，即可
#为了获得独立性，为了和存储于服务器上mysql数据库通信，我们加载包RMySQL
#下面的程序是在Linux系统上加载的
#在Linux系统上运行R软件，连接mysql数据库最容易的途径是通过DBI包与RMySQL包结合
#两个包安装后可以直接在Linux系统上运行不需要像在windows上安装驱动
library(DBI)
library(RMySQL)
#打开MySQL数据库驱动
drv <- dbDriver("MySQL")
#连接数据库
#drv 驱动来源
#dbname 数据库的名字
#user 数据框用户名
#password 数据框密码
#host 服务器地址
# 连接服务器sql.com上， 用户名为user，密码为password 的dbname 数据库
ch <- dbConnect(drv,dbname="Quotes",user = "myusername", 
                password = "mypassword" 
                #host = ‘sql.com’
                )



#dbListTables()显示数据库中数据表和字段信息
table.names = dbListTables(ch)
#显示ch数据库中，my_table表中的字段信息
fileds.names = dbListTables(ch, "my_table")

#将数据读入R
dbReadTable(ch, "my_table")

#查询数据库，用dbGetQuery()函数向数据库发送sql命令，收到一个数据框结果
#运行sql语句，将结果输出为R的数据框
allQuotes <- dbGetQuery(ch,"select * from gspc")

#提交查询
#运行sql语句并将结果输出为结果集对象，非R数据框
res = dbSendQuery(ch, "select * from my_table")

#res的结果仍然在Mysql服务器上，要在R中获取这些结果需要使用fetch函数
#返回结果保存为R数据框
#获取记录, n = -1 表示获取结果集中的所有记录
dat = fetch(res, n = 100)
#等价于
dat = dbGetQuery(con, "select * from my _table limit 100")

#将时间结果转化为xs对象
GSPC <- xts(allQuotes[,-1],order.by=as.Date(allQuotes[,1]))
head(GSPC)

#获取sql数据库连接有关的信息
summary(MySQL(), verbose = TRUE)
summary(ch, verbose = TRUE)
summary(res, verbose = TRUE)

#关闭数据库
dbDisconnect(ch)

#关闭数据库驱动
dbUnloadDriver(drv)

#可以把mysql数据库作为函数getSymbols()的一个数据源
setSymbolLookup(GSPC=list(name='gspc',src='mysql',
                          db.fields=c('Index','Open','High','Low','Close','Volume','AdjClose'),
                          user='xpto',password='ypto',dbname='Quotes'))
getSymbols('GSPC')
