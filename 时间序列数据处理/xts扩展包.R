#######
#xts扩展zoo的基础结构，由3部分组合。

#索引部分：时间类型向量
#数据部分：以矩阵为基础类型，支持可以与矩阵相互转换的任何类型
#属性部分：附件信息，包括时区，索引时间类型的格式等
#4. xts的API介绍

#xts基础
#（1） xts基础
#xts: 定义xts数据类型，继承zoo类型
#coredata.xts: 对xts部分数据赋值
#xtsAttributes: xts对象属性赋值
#[.xts: 用[]语法，取数据子集
# dimnames.xts: xts维度名赋值
# sample_matrix: 测试数据集，包括180条xts对象的记录，matrix类型
# xtsAPI: C语言API接口

#（2） 类型转换 
# as.xts: 转换对象到xts(zoo)类型
# as.xts.methods: 转换对象到xts函数
## plot.xts: 为plot函数，提供xts的接口作图
# .parseISO8601: 把字符串(ISO8601格式)输出为，POSIXct类型的，包括开始时间和结束时间的list对象
# firstof: 创建一个开始时间，POSIXct类型
# #lastof: 创建一个结束时间，POSIXct类型
# indexClass: 取索引类型
# .indexDate: 取索引的
# .indexday: 索引的日值
# .indexyday: 索引的年(日)值
# .indexmday: 索引的月(日)值
# .indexwday: 索引的周(日)值
# .indexweek: 索引的周值
# .indexmon: 索引的月值
# .indexyear: 索引的年值
# .indexhour: 索引的时值
# .indexmin: 索引的分值
# .indexsec: 索引的秒值

# （3）数据处理 
# align.time: 以下一个时间对齐数据，秒，分钟，小时
# endpoints: 按时间单元提取索引数据
# merge.xts: 合并多个xts对象，重写zoo::merge.zoo函数
# rbind.xts: 数据按行合并，为rbind函数，提供xts的接口
# split.xts: 数据分隔，为split函数，提供xts的接口
# na.locf.xts: 替换NA值，重写zoo:na.locf函数

# （4）数据统计 
# apply.daily: 按日分割数据，执行函数
# apply.weekly: 按周分割数据，执行函数
# apply.monthly: 按月分割数据，执行函数
# apply.quarterly: 按季分割数据，执行函数
# apply.yearly: 按年分割数据，执行函数
# to.period: 按期间分割数据
# period.apply: 按期间执行自定义函数
# period.max: 按期间计算最大值
# period.min: 按期间计算最小值
# period.prod: 按期间计算指数
# period.sum: 按期间求和
## nseconds: 计算数据集，包括多少秒
# nminutes: 计算数据集，包括多少分
# nhours: 计算数据集，包括多少时
# ndays: 计算数据集，包括多少日
# nweeks: 计算数据集，包括多少周
# nmonths: 计算数据集，包括多少月
# nquarters: 计算数据集，包括多少季
# nyears: 计算数据集，包括多少年
# periodicity: 查看时间序列的期间

# （5）辅助工具# 
# first: 从开始到结束，设置条件取子集
# last: 从结束到开始，设置条件取子集
# timeBased: 判断是否是时间类型
# timeBasedSeq: 创建时间的序列
# diff.xts: 计算步长和差分
# isOrdered: 检查向量是否是顺序的
# make.index.unique: 强制时间唯一，增加毫秒随机数
# axTicksByTime: 计算X轴刻度标记位置按时间描述
# indexTZ: 查询xts对象的时区



# 5. xts使用 
# 1). xts类型基本操作
#2). xts的作图
#3). xts类型转换
#4). xts数据处理
#5). xts数据统计计算
#6). xts时间序列工具使用
################################################

############1). xts类型基本操作##################

#测试数据集sample_matrix
#zoo包的扩展包

library(xts)
data(sample_matrix)
head(sample_matrix)

#定义xts类型对象
sample.xts <- as.xts(sample_matrix, descr='my new xts object')
class(sample.xts)
str(sample.xts)
head(sample.xts)
attr(sample.xts,'descr') #获得属性

#xts数据查询
head(sample.xts['2007'])
head(sample.xts['2007-03/'])
head(sample.xts['2007-03-06/2007'])
sample.xts['2007-01-03']

##############2). 操作xts的作图########
data(sample_matrix)
plot(sample_matrix)
plot(as.xts(sample_matrix))

#k线图
plot(as.xts(sample_matrix), type='candles')


####################3). xts类型转换#################
#分别创建首尾时间：firstof, lastof
#  first.time"2000-01-01 CST" last.time  "2000-12-31 23:59:59 CST"
.parseISO8601('2000')

#first.time "2000-05-01 CST"   last.time "2001-02-28 23:59:59 CST"
.parseISO8601('2000-05/2001-02')

#first.time "2000-01-01 CST"   last.time "2000-02-29 23:59:59 CST"
.parseISO8601('2000-01/02')

#first.time "1970-01-01 08:30:00 CST" last.time "1970-12-31 15:00:59 CST"
.parseISO8601('T08:30/T15:00')

#取索引类型
x <- timeBasedSeq('2010-01-01/2010-01-02 12:00')
x <- xts(1:length(x), x)
head(x)
indexClass(x)

#索引时间格式化
indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3"
head(x)
indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3"
head(x)

#取索引时间
.indexhour(head(x))
.indexmin(head(x))

#############4). xts数据处理#####################
#数据对齐, 以秒为计算单位
x <- Sys.time() + 1:30
#整10秒对齐
align.time(x, 10)
##整60秒对齐
align.time(x, 60)
#按时间分割数据，并计算

#按时间分割数据，并计算
xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
#计算的值都放在每个月的最后一天
apply.monthly(xts.ts,mean)
apply.monthly(xts.ts,function(x) var(x))
apply.quarterly(xts.ts,mean)
apply.yearly(xts.ts,mean)

#按期间分隔：to.period， zzhua转化为zoo xts对象
data(sample_matrix)
to.period(sample_matrix)
class(to.period(sample_matrix))
samplexts <- as.xts(sample_matrix)
to.period(samplexts)
class(to.period(samplexts))

#按期间分割索引数据
data(sample_matrix)
endpoints(sample_matrix)
endpoints(sample_matrix, 'days',k=7)
endpoints(sample_matrix, 'weeks')
endpoints(sample_matrix, 'months')

#数据合并：按列合并， 没对应的值用NA填补
(x <- xts(4:10, Sys.Date()+4:10))
(y <- xts(1:6, Sys.Date()+1:6))
merge(x,y)

#取索引将内连接， 即取得两列都非空的部分（取x y时间上的交集）
merge(x,y, join='inner')

#左连接，即(x 加上x y的交集)
merge(x,y, join='left')

#数据合并：按行合并
x <- xts(1:3, Sys.Date()+1:3)
rbind(x,x)

#####数据切片：按行切片
data(sample_matrix)
x <- as.xts(sample_matrix)

#按月切片； 1是切片一月份
split(x)[[2]]

#按周切片
split(x, f="weeks")[[1]]

#NA值处理
x <- xts(1:10, Sys.Date()+1:10)
x[c(1,2,5,9,10)] <- NA
x
#只保留最前面的NA, 其余被填补了
na.locf(x)
#取后一个
na.locf(x, fromLast=TRUE)

#############5). xts数据统计计算###########
#取开始时间，结束时间
xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
start(xts.ts)
end(xts.ts)
periodicity(xts.ts)

#计算时间区间
data(sample_matrix)

#天数
ndays(sample_matrix)
#周
nweeks(sample_matrix)
#月
nmonths(sample_matrix)
#季度
nquarters(sample_matrix)
#年
nyears(sample_matrix)

#按期间计算统计指标
zoo.data <- zoo(rnorm(31)+10,as.Date(13514:13744,origin="1970-01-01"))

#按周获得期间
ep <- endpoints(zoo.data,'weeks')
ep

#计算周的均值
period.apply(zoo.data, INDEX=ep, FUN=function(x) mean(x))
#计算周的最大值
head(period.max(zoo.data, INDEX=ep))
#计算周的最小值
head(period.min(zoo.data, INDEX=ep))
#计算周的一个指数值
head(period.prod(zoo.data, INDEX=ep))

###############6). xts时间序列工具使用

#检查时间类型
timeBased(Sys.time())
timeBased(Sys.Date())
timeBased(200701)

#创建时间序列
#按年 ,显示每年的一月一日
timeBasedSeq('1999/2008')

#按月
head(timeBasedSeq('199901/2008'))

#按日
head(timeBasedSeq('199901/2008/d'),40)

#按数量创建，100分钟的数据集
#空格前是年月日， 空格后是时分秒
timeBasedSeq('20080101 0830',length=100)

#按索引取数据first, last
x <- xts(1:100, Sys.Date()+1:100)
head(x)
first(x, 10)
first(x, '1 day')
last(x, '1 weeks')

#计算步长和差分
x <- xts(1:5, Sys.Date()+1:5)
#差分
lag(x)
#反向
lag(x, k=-1, na.pad=FALSE) 
#1阶差分
diff(x)
#2阶差分
diff(x, lag=2)

#检查向量是否排序好的
isOrdered(1:10, increasing=TRUE)
isOrdered(1:10, increasing=FALSE)
isOrdered(c(1,1:10), increasing=TRUE)
isOrdered(c(1,1:10), increasing=TRUE, strictly=FALSE)

#强制唯一索引
x <- xts(1:5, as.POSIXct("2011-01-21") + c(1,1,1,2,3)/1e3)
x
make.index.unique(x)

#查询xts对象时区
x <- xts(1:10, Sys.Date()+1:10)
indexTZ(x)
tzone(x)
str(x)





