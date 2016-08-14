
library(dplyr)

##基本函数
#filter() ;slice() 
#arrange()
#select() (and rename())
#distinct()
#mutate() (and transmute())
#summarise()
#sample_n() and sample_frac()

#######################################
##使用filter(); slice()选择数据集的子集
#install.packages('nycflights13')
library(nycflights13)
dim(flights)
head(flights)
class(flights)
data(flights)
#unique(flights$year)

###################1 基本操作####################################
###############1.1 筛选: filter()#################
#按给定的逻辑判断筛选出符合要求的子数据集, 类似于 base::subset() 函数
#注意: 表示 AND 时要使用 & 而避免 &&
#先按month 然后按day 取数据,
filter(flights, month == 1, day == 1)
#等同于
flights[flights$month == 1 & flights$day == 1, ]
#filter() 类似于 to subset() 可以用&  |  等逻辑符号
filter(flights, month == 1 | month == 2)

#slice 选取1:10行
slice(flights, 1:10)
slice(flights, c(1,3,5))

##################1.2 排列: arrange()#############################
#这个函数和 plyr::arrange() 是一样的, 类似于 order()
#按给定的列名依次对行进行排序.
#arrange() 排序，默认升序排列
arrange(flights, year, month, day)
#desc 按照降序排列
arrange(flights, desc(arr_delay))

#等价于
flights[order(flights$year, flights$month, flights$day), ]
flights[order(desc(flights$arr_delay)), ]

###################1.3 选择: select()##############################
#用列名作参数来选择子数据集:
##select() (and rename()) 选择变量（列）
select(flights, year, month, day)
#可以用 : 来连接列名, 没错, 就是把列名当作数字一样使用:
select(flights, year:day)
#用 - 来排除列名:
select(flights, -(year:day))
#选择变量tailnum并改变变量名称为tail_num
select(flights, tail_num = tailnum)
#同样类似于R自带的 subset() 函数 (但不用再写一长串的 c("colname1", "colname2") 
#或者 which(colname(data) == "colname3"), 甚至还要去查找列号)


#更改列变量名称
rename(flights, tail_num = tailnum)

######################################
#选择行值的唯一子集， 类似于unique()
#distinct()
distinct(select(flights, tailnum))
distinct(select(flights, origin, dest))

##############1.4 变形: mutate()######################
#对已有列进行数据运算并添加为新列:
#mutate() (and transmute())
#mutate() 类似于plyr::mutate() 类似于base::transform().优势在于可以在同一语句中对刚增加的列进行操作:
mutate(flights,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60)
#而同样操作用R自带函数 transform() 的话就会报错:
transform(flights,
          gain = arr_delay - delay,
          gain_per_hour = gain / (air_time / 60)
          )
#如果只保留新的变量，使用transmute
transmute(flights,
          gain = arr_delay - dep_delay,
          gain_per_hour = gain / (air_time / 60)
)

##################1.5 汇总: summarise()######################
#数据汇总,对数据框调用其它函数进行汇总操作, 返回一维的结果:
#summarise()
summarise(flights,
          delay = mean(dep_delay, na.rm = TRUE))

#########################################
#随机抽样 
#sample_n() and sample_frac()

#sample_n()随机抽取10行
sample_n(flights, 10)
#sample_frac()随机抽取某个比例的数据
sample_frac(flights, 0.01)



###################2 分组动作 group_by()######################
#以上5个动词函数已经很方便了, 但是当它们跟分组操作这个概念结合起来时, 那才叫真正的强大! 
#当对数据集通过 group_by() 添加了分组信息后,mutate(), arrange() 和 summarise() 
#函数会自动对这些 tbl 类数据执行分组操作 (R语言泛型函数的优势).
#基于分组数据操作#group_by()
#对飞机航班数据按飞机编号 (TailNum) 进行分组, 计算该飞机航班的次数 (count = n()), 
#平均飞行距离 (dist = mean(Distance, na.rm = TRUE)) 和 
#延时 (delay = mean(ArrDelay, na.rm = TRUE))
by_tailnum <- group_by(flights, tailnum)
#分组之后，上面所有的函数会对每个组进行同样的运算
#n()计算分组的频数，na.rm是否移除NA
delay <- summarise(by_tailnum,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE))

delay <- filter(delay, count > 20, dist < 2000)
#用 ggplot2 包作个图观察一下, 发现飞机延时不延时跟飞行距离没太大相关性:
library(ggplot2)
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()


#分成二维数据集
destinations <- group_by(flights, dest)
#n_distinct(x) 计算x变量有多少个不同的值
summarise(destinations,
          planes = n_distinct(tailnum),
          flights = n()
)

#分成三维数据集
daily <- group_by(flights, year, month, day)
(per_day   <- summarise(daily, flights = n()))
(per_month <- summarise(per_day, flights = sum(flights)))
(per_year  <- summarise(per_month, flights = sum(flights)))

##########################################################
#同data.frame一样
data.frame(x = letters) %>% sapply(class)
data_frame(x = letters) %>% sapply(class)
data_frame(x = 1:3, y = list(1:5, 1:10, 1:20))

#还能创建纵向的列表list
data_frame(x = 1:3, y = list(1:5, 1:10, 1:20))

data.frame(`crazy name` = 1) %>% names()
data_frame(`crazy name` = 1) %>% names()
data_frame(x = 1:5, y = x ^ 2)

data_frame(x = 1:5) %>% class()
#as_data_frame()可以将list列表转化为数据框
#as.data.frame()不能将列表转化为数据框，但是可以用
# do.call(cbind, lapply(x, data.frame)) 进行转化
#数据处理链
#1 可以一步一步的处理数据集
a1 <- group_by(flights, year, month, day)
a2 <- select(a1, arr_delay, dep_delay)
a3 <- summarise(a2,
                arr = mean(arr_delay, na.rm = TRUE),
                dep = mean(dep_delay, na.rm = TRUE))
a4 <- filter(a3, arr > 30 | dep > 30)

#2 可以嵌套处理链
filter(
  summarise(
    select(
      group_by(flights, year, month, day),
      arr_delay, dep_delay
    ),
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ),
  arr > 30 | dep > 30
)

#3 可以使用数据流处理
flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)

###################汇总是小函数
#另: 一些汇总时的小函数
#n(): 计算个数
#n_distinct(): 计算 x 中唯一值的个数. (原文为 count_distinct(x), 测试无用)
#first(x), last(x) 和 nth(x, n): 返回对应秩的值, 类似于自带函数 x[1], x[length(x)], 和 x[n]
#注意: 分组计算得到的统计量要清楚样本已经发生了变化, 此时的中位数是不可靠的

#3 连接符 %.%
#包里还新引进了一个操作符, 使用时把数据名作为开头, 然后依次对此数据进行多步操作.
Batting %.%
  group_by(playerID) %.%
  summarise(total = sum(G)) %.%
  arrange(desc(total)) %.%
  head(5)

#这样可以按进行数据处理时的思路写代码, 一步步深入, 既易写又易读, 接近于从左到右的自然语言顺序, 对比一下用R自带函数实现的:
head(arrange(summarise(group_by(Batting, playerID), total = sum(G)) , desc(total)), 5)

totals <- aggregate(. ~ playerID, data=Batting[,c("playerID","R")], sum)
ranks <- sort.list(-totals$R)
totals[ranks[1:5],]
#文章里还表示: 用他的 MacBook Air 跑 %.% 那段代码用了 0.036 秒, 跑上面这段代码则用了 0.266 秒, 运算速度提升了近7倍. (当然这只是一例, 还有其它更大的数字.)
#更多请 ?"%.%", 至于这个新鲜的概念会不会和 ggplot2 里的 + 连接号一样, 发挥出种种奇妙的功能呢? 还是在实际使用中多体验感受吧.
