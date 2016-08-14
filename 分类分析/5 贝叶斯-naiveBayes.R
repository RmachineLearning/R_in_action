#5 贝叶斯分类
setwd("/media/zhoutao/软件盘/workspace/R/Data for An Introduction to Statistical Learning with Applications in R ")

##1 收集数据集，探索数据
library(kernlab)
#reuters {kernlab}， 文本数据 ，是一个40的列表文本文档，
#reuters包含文本文件，rlabels包含文件的标签
data(reuters)
is(reuters)
names(reuters)
str(reuters)
#rlables包含对应40个文本文档的分类标签
table(rlabels)

#####2 数据准备 —— 处理和分析文本数据
##tm包处理文本数据，同时加载nlp库
library(tm)

#将列表化为数据框，首先转化为矩阵matrix
#然后，给矩阵的列或者行附上名称, 然后再转化为dataframe
reuters_df = as.matrix(reuters)
colnames(reuters_df) =  'text'

#将每个文档的名称rlabels 与文档结合在一起
#reuters_lab = cbind(text = reuters_df, type = as.character(rlabels))
#因为rlabels是一个向量，所以可以用type进行命名，但是reuters_df是矩阵，则就不能用text命名
reuters_lab = cbind(reuters_df, type = as.character(rlabels))
class(reuters_lab) #cbind（)函数得到的数据是matrix类型
#class(reuters_lab)
#为两列命名
#colnames(reuters_lab) = c('text', 'type') 
#去掉行名
#rownames(reuters_lab) = NULL
#再转化为数据框结构
reuters_lab = as.data.frame(reuters_lab)
#str(reuters_lab)
#names(reuters_lab)
#View(reuters_lab)
#class(reuters_lab)
#head(reuters_df)

##处理文本数据第一步创建一个语料库，即一个文本文件集合，
#VectorSource()函数，指定reuters_df 被Corpus()函数使用
#函数Corpus()函数创建一个R对象来存储文本文档， 它可以通过参数来指定加载文本文档的格式
#可以读取word文档，PDF文件等, 存放在一个列表中
reuters_tm = Corpus(VectorSource(reuters_lab$text))
print(reuters_tm)
#查看语料库里面的内容可以用inspect()
inspect(reuters_tm[1:3])

###用tm_map()提供一种用来转换（映射）tm语料库的方法
####就是把后面的函数，映射到面的数据上
    #首先 将所有字母变成小写，并去除所有的数字
reuters_tm_clean = tm_map(reuters_tm, tolower)
reuters_tm_clean = tm_map(reuters_tm_clean , removeNumbers)

    #删除停用词
reuters_tm_clean = tm_map(reuters_tm_clean,  removeWords, stopwords())
    #去除标点符号
reuters_tm_clean = tm_map(reuters_tm_clean,  removePunctuation)
   #前面删除的数字、标点、停用词的地方都变成了空格，所以去掉额这些外空格， 
   #只保留词与词之间留一个空格
reuters_tm_clean = tm_map(reuters_tm_clean,  stripWhitespace)

#对给定的tm语料库，用DocumentTermMatrix()将一个语料库作为输入
#创建一个稀疏矩阵,其中矩阵的行表示文档， 矩阵列表示单词，矩阵中的每个单元存储一个数字，它代表
#由列标识的单词出现在由行所标识的文档中的次数
   #首先通过tm_map()将语料库，转化为稀疏文档PlainTextDocument，
    #然后才能转化为稀疏矩阵DocumentTermMatrix
reuters_tm_clean_plain = tm_map(reuters_tm_clean, PlainTextDocument)

#将文档转化为稀疏矩阵，这个矩阵的行是每篇文本，列是所有的字符
reuters_dtm = DocumentTermMatrix(reuters_tm_clean_plain)
#将文档转化为稀疏矩阵，这个矩阵的行是每个单词，列是每篇文本
reuters_tdm = TermDocumentMatrix(reuters_tm_clean_plain)


###############################################################
##3 数据准备，建立训练集和测试集数据

   #1 得到一个文档-单词矩阵，就是reuters_dtm这个稀疏矩阵的训练集和测试集
   #dim(reuters_dtm)
#order 返回的是 从小到达 值的位置， 那么dtm取出来的值是从小到大开始取的
   #reuters_dtm_order = reuters_dtm[order(runif(40)),]
#或者随机取，从1-40中取出35个数
ind = sample(40, 20)
reuters_tdm_train = reuters_tdm[ ,ind]
reuters_tdm_test = reuters_tdm[ ,-ind]
class(reuters_tdm_train)
  #2 将文档数据框分解成训练集和测试集
reuters_lab_train = reuters_lab[ind, ]
reuters_lab_test = reuters_lab[-ind,  ] 
#dim(reuters_lab_train)
#names(reuters_lab_train)
#class(reuters_lab_train )

  #3 语料库 分解
reuters_tm_clean_train = reuters_tm_clean[ind]
reuters_tm_clean_test = reuters_tm_clean[-ind]


#检查上述子集是一组完整的文本代表，查看训练集和测试集 中类别所占的比例，如果相同
#则说明 两类是平均分配到这两个数据集中的, 这个案例 样本比较少，所以难免由问题
prop.table(table(reuters_lab_train$type))
prop.table(table(reuters_lab_test$type))


  #4 可视化文本数据 ——词云
#install.packages('wordcloud')
library(wordcloud)

#将文档-词项稀疏矩阵，转化为矩阵, 要将词排在行，文本文件放在列
reuters_tdm_m = as.matrix(reuters_tdm)
#计算每列(即每个单词的频数)，并排序
ci_sum = sort(rowSums(reuters_tdm_m), decreasing = TRUE)
class(ci_sum)
#把词频和词语组合到数据框中
d = data.frame(word = names(ci_sum), freq=ci_sum)
#min.freq用来指定显示在词云中的单词必须满足在语料库中
#出现的最小次数，random.order = FALSE 表示词云将以非随机的顺序排列，词频高的单词越靠近中心
#scale允许调整词云中单词的最大字体和最小字体
wordcloud(d$word,d$freq,max.words = 40, scale = c(3, 0.5))


###对训练集做词云
tdm_train_m = as.matrix(reuters_tdm_train)
tdm_sum = sort(rowSums(tdm_train_m), decreasing = TRUE)
tdm_train_d = data.frame(word = names(tdm_sum), freq = tdm_sum)
wordcloud(tdm_train_d$word,tdm_train_d$freq,max.words = 40, scale = c(3, 0.5))


#3 准备数据——为频繁出现的单词创建指示特征
#稀疏矩阵 包含的特征(单词数)超过7000个，为了减少特征，剔除训练数据中少于5个文本，或者少于记录总数
#0.1%的所有单词
#使用tm包中findFreqTerms()函数
#findFreqTerms(x, lowfreq = 0, highfreq = Inf)
#x 可以是 DocumentTermMatrix or TermDocumentMatrix.
d = findFreqTerms(reuters_tdm_train, 5)
class(d)















##4 贝叶斯分类
#install.packages('e1071')
library(e1071)
#m = naiveBayes(train, class, laplace = 0)
#train 训练集
#class 训练数据每一行的分类的因子向量
#laplace 控制拉普拉斯估计的一个值 默认为0 ，
#返回一个朴素贝叶斯对象，该对象用于预测

#p = predict(m, test, type = 'class')
#m 模型
#test  测试集
# type 为 'class'  'raw'标识预测是最可能的类别值或原始的预测概率

#性能评估
library(gmodels)
CrossTable(p, )
CrossTable(p, test$class, digits=3, prop.r=TRUE, prop.c=TRUE,
           prop.t=TRUE, prop.chisq=FALSE,dnn = c('predictied', 'actual'))

#提升性能 
更改拉普拉斯 参数