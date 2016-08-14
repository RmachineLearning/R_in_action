#关联分析
getwd()
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

##1 收集数据
#install.packages("arules")  构建事务的包
library(arules)

###############################################################
##2 构建事务， 有三种构造，物品的购买关系
#transactions 表示事务型数据类型，也就是几个相关的事物放在一起：
#例如买东西是一个事务，这个购买行为，买了苹果、橘子、梨子，这三样东西构成一个事务
#下次购买行为又是一个事务，
#如果一次购买行为放在一个列表中，要把列表转化为transections 数据格式， 

#1 列表， 只能存储每次事务够买的种类
tr_list = list(c("Apple", "Bread", "Cake"),
               c("Apple", "Bread", "Milk"),
               c("Bread", "Cake", "Milk"))
#并且命名购买关系的名称， 每个列表有一个名称
names(tr_list) = paste("Tr",c(1:3), sep = "")
 
trans = as(tr_list, "transactions")
trans
image(trans) #查看事务分布

#2 矩阵，能够存储事务 、但是不能判断每个事务购买的种类 、能够存储每个种类买了多少东西
#如过要存储一个购买行为，买了东西各多少个，用矩阵存放，同样要转化为transections
#行表示购买行为（即事务）， 列表示购买的东西的名称， 中间的数字表示购买的数量
tr_matrix = matrix(c(1,1,1,0,
                     1,1,0,1,
                     0,1,1,1), ncol = 4)

dimnames(tr_matrix) = list(
                        paste("Tr",c(1:3), sep = ""),
                        c("Apple","Bread","Cake", "Milk")
                          )
trans2 = as(tr_matrix, "transactions")
trans2
image(trans2)

#3 数据框， 能够存储事务  每个事务的种类  每个种类买了多少东西
#数据框表示方法，购买行为(事务)和购买的东西都在列上，属于长数据longdata
Tr_df = data.frame(TrID= as.factor(c(1,2,1,1,2,3,2,3,2,3)),
                   Item = as.factor(c("Apple","Milk","Cake","Bread",
                                      "Cake","Milk","Apple","Cake",
                                      "Bread","Bread"))
                  )
#将
trans3 = as(split(Tr_df[,"Item"], Tr_df[,"TrID"]),
              "transactions")
trans3
image(trans3)
###########################################################

###3 查看事务数据
 #1 用LIST查看
 LIST(trans)
 LIST(trans3)
 #2 用summary
 summary(trans3)
 #查看稀疏矩阵
 inspect(trans)

###4 截取transactions数据
  #size 表示大于3个东西
filter_trains = trans[size(trans) >=3]
inspect(filter_trains)

###5 对事务建立柱形图
itemFrequencyPlot(trans)

##########################################################

#收集数据， 这是一个事务数据， 事务数据的列表示商品，行表示购买行为(事务)
#如果是从csv格式中读取事务格式，则使用read.transactions(file, sep = ',')读入到稀疏矩阵中
data(Groceries)
class(Groceries)
#9835 rows 指交易的次数
#169 columns 指可能出现在消费购物篮中的169类不同商品的每一类的特征，
#如果在相对的交易中该商品被购买了，则矩阵中的该单元为1 否则为0
#density of 0.02609146 表示非零矩阵单元的比例， 因为983×5169 = 1662115个位置
#一共由 1662115×0.02609146 = 43367个商品被购买，
#被频繁购买的前5项商品在most frequent items中
#那么 whole milk 2513/9835 = 25.6% 的概率在交易中出现
#element (itemset/transaction) length distribution:
#是说有2519次交易购买单一商品， 有一次交易，购买了32类商品(最后一个统计)
#分位数统计的是，购买规模，25%的交易包含了两件或者更少的商品，有一般以上的交易中商品在3类左右。
summary(Groceries)

#截取前5个事务
inspect(Groceries[1:5])
#截取购买次序前5名的商品
itemFrequencyPlot(Groceries[,1:5])

#可视化商品的支持度——商品的频率图
#topN = 5 画购买量前5名的商品的支持度图，支持度为support = 0.1 表示选择购买频率在0.1之上的商品
itemFrequencyPlot(Groceries, support = 0.1, cex.names=0.8,topN=5)


#可视化购买量数据——绘制稀疏矩阵，对事务画图
#黑色表示在事务中，行表示事务，列表示商品(竖线分割商品)
image(Groceries[1:5])
#随机抽取100个事务， 这个图有助于解释交易或者商品的有趣部分
#例如，购买按日期排序，则黑色原点的图案可能会揭示人们购买商品数量或者类型的季节性变化
image(sample(Groceries, 100))

# 基于数据训练模型，apriori()算法在arules包中， 项集表示一次购买行为中，所有的东西组成的集合
#apriori算法采用的先验信念作为准则，来减少关联规则的搜索空间：一个频繁项集的所有子集必须也是频繁项
#如果搜索出{机油， 口红}是频繁项集，但是其中某一项不是频繁项，那么这个频繁项就会被从搜索中排除掉

#apriori算法用一下方法减少搜索次数
  #1 度量规则兴趣度—— 支持度 置信度
#支持度 是直一个项集在数据中出现的频率
#例如：{慰问卡}{鲜花}在医院礼品店数据中的支持度是3/5 = 0.6，那么{慰问卡} ==>{鲜花}的支持度也是0.6
#support(x) = count(x)/N
#N表示数据库中的交易次数，count(x)表示项集x出现在交易中的次数

#置信度规则，指该规则的预测能力或者准确度的度量, x的出现导致y的出现的比例，但是y的出现导致x的出现比例就不一样
confidence(x ==> y) = support(x,y)/suport(x)

#aoriori算法
#该算法创建过程分为两部分：
#1 识别所有满足最小支持度阀值的项集
#2 根据满足最小置信度的这些相集来创建规则

#Groceries 事务的稀疏矩阵
#support 给出要求的最低规则支持度，
#confidence 给出要求的最低规则置信度
#minlen 给出要求的规则最低项数
#返回一个满足最低准则要求的规则对象
rules = apriori(Groceries, parameter = list(support = 0.001, 
                                            confidence = 0.5,
                                            minlen = 2,
                                            target= "rules"))
#评估模型性能
#set of 5668 rules 一共由5668条规则
#rule length distribution (lhs + rhs):sizes 
#有11个规则包含2类商品；46个规则包含6类商品
#规则的规模（大小）是由规则的前项（条件项或左项lhs）与规则后项（结果项或右项 rhs）相加得到
#{bread} => {butter} 前项 =》 后项 为2项；{bread，jielly} => {butter} 前项 =》 后项 为3项
#summary of quality measures:
#提升度 lift 度量标准：假设你知道另一类商品已经被购买了，提升度就是用来衡量一类商品相对于它
#的一般购买率，此时购买的可能性由多大， lift（x=》y） = confi（x=》y）/support（x）
#lift（x=》y） == lift（y =》x）等价的
#confi是不等价的
#mining info:
#告诉我们如何选择规则，包含9835次交易的Groceries 数据，用来构建最小支持度为0.001，与置信度
#为0.5的规则
summary(rules)

#使用inspect()查看具体的规则
#规则说明，购买{honey}  => 会购买{whole milk}的支持度为0.001，说明该规则涵盖了大约0.1%的交易
#confidenc 为0.7 说明买了{honey} 会买{whole milk}购买的正确率为70%
#lift 告诉我们，假定一个顾客购买了{honey} 相对其他一般顾客(买了honey但没买whole milk) 
#会买whole milk的可能性为2.87，是一般顾客的2.87倍， 因为买whole milk 的支持度是25.6% = 2513/9835
#所有提升度为0.73/25.6% = 2.87
inspect(rules[1:3])

#查看关联规则,按照lift排序
inspect(sort(rules, by = 'lift')[1:5])

#提取关联规则的子集
#用subset()寻找交易、商品、规则子集的方法，
#在所有规则中，查找那些包含cocoa drinks的所有规则
#items 与出现规则任何位置的项相匹配， 为了将子集匹配到只发生在左侧或右侧，则用lhs 和rhs代替items
#%in%意味着至少有一项在定义的列表中可以找到
#部分匹配（%pin%） items %pin% fruit  既能匹配citrus fruit 又能匹配  tropical fruit
#完全匹配（%ain%） items %in% c('berries', 'yogurt') 只能找到两个同时拥有的规则
#用subset 也可以选择 支持度 置信度  提升度加以限制， confidenc > 0.5 ,只能找到大于50%的置信度规则
#用 & | ！ 这些符号来取得 结合式的规则
cocoadrinksrules = subset(rules, items %in% 'cocoa drinks')
inspect(cocoadrinksrules)

#把规则保存到csv文件中
write(rules, file = 'Groceries.csv', sep = ',', quote = TRUE, row.names = FALSE)

#将规则转化为数据框
rule_df = as(rules, 'data.frame')
str(rule_df)



