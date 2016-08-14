install.packages("rjson")
#1. rjson包介绍
#rjson是一个R语言与json进行转的包，是一个非常简单的包，支持用 C类库转型和R语言本身转型两种方式。
#rjson库，提供的函数只有3个，fromJSON(), newJSONParser(), toJSON()。 
#下面我们将介绍rjson库如何使用。


library(rjson)
setwd("/media/zhoutao/软件盘/workspace/R/R in Action/json")
#2). fromJSON() 从JSON到R
#从fin0.json文件中，读取JSON并解析为R语言对象。
json_data <- fromJSON(paste(readLines("fin0.json"), collapse=""))
json_data

#我们看到原JSON，除最内层都被解析为R的list类型，最内层则是向量类型。
#在R对象结构中取叶子节点, json.table1.data.code[0]
json_data$table1$data$code
json_data$table1$data$code[1]

#3). toJSON() 从R到JSON
#把R对象序列化为JSON串，还以刚才的json_data为例
json_str<-toJSON(json_data)
print(json_str)
cat(json_str) #原格式查看数据

#我们只要使用toJSON()函数，就可以实现R对象向JSON的转成。
#如果用print结果就是带转义的输出(\”)，直接用cat打印就是标准的JSON串格式。
#把JSON输出到文件：fin0_out.json, 有2种方法：
#1. writeLines()
#2. sink()
# writeLines
writeLines(json_str, "fin0_out1.json")

# sink
sink("fin0_out2.json")
cat(json_str)
sink()
#虽然写法不同，输出结果是一个样的，writeLines最后新建一个空行。

#4). C库和R库转型 性能测试
#我们对fromJSON进行性能测试
system.time( y <- fromJSON(json_str,method="C") )
system.time( y2 <- fromJSON(json_str,method = "R") )
system.time( y3 <- fromJSON(json_str) )
#我们可以看到，C库比R库会快，因为数据量很小，所以0.02并不明显。当JSON串很大的时候，这个差距就会变得相当的大了。
#另外，fromJSON默认使用的C库的方法，所以我们平时处理不用加method='C'的参数。
#toJSON的性能测试
system.time( y <- toJSON(json_data,method="C") )
system.time( y2 <- toJSON(json_data,method = "R") )
system.time( y3 <- toJSON(json_data) )



###############2. RJSONIO包介绍######################
#RJSONIO包，提供了2个主要的操作，把JSON串反序列化成R对象，把R对象序列化成JSON串，两个主要的函数fromJSON(), toJSON()，还包括几个辅助函数asJSVars(), basicJSONHandler(), Bob(), isValidJSON(), readJSONStream()。
#RJSONIO包开发，是解决了rjson包序列化大对象慢的问题。RJSONIO依赖于底层的C语言类库libjson。
install.packages("RJSONIO")
library(RJSONIO)
#2). fromJSON() 从JSON到R
#同rjson一样，测试fromJSON函数
json_data <- fromJSON(paste(readLines("fin0.json"), collapse=""))
json_data

#我们发现与 rjson的解析结果是一样，都是基于list的
#取叶子节点：
json_data$table1$data$code
json_data$table1$data$code[1]

#3). toJSON() 从R到JSON
#toJSON测试
json_str<-toJSON(json_data)
print(json_str)
cat(json_str) #格式化输出

#toJSON函数输出与rjson是不一样的，这个输出是格式化的。
#输出到文件：
writeLines(json_str, "fin0_io.json")

#4). isValidJSON() 验证JSON是否合法
#验证JSON的格式，是否合法。
isValidJSON(json_str)
isValidJSON(json_str,TRUE) #检查整体是否为json格式
isValidJSON(I('{"foo" : "bar"}'))
isValidJSON(I('{foo : "bar"}')) #foo少了双引号

#4). asJSVars() 转换为Javascript变量格式；得到JS两个变量，数组a和二维数组myMatrix.
cat(asJSVars( a = 1:10, myMatrix = matrix(1:15, 3, 5)))


#3. 自定义JSON的实现
#我们把R的data.frame对象转成我们定义的JSON格式。
#下面JSON的定义格式
[
{
  "code": "TF1312",
  "rt_time": "152929",
  "rt_latest": 93.76,
  "rt_bid1": 93.76,
  "rt_ask1": 90.76,
  "rt_bsize1": 2,
  "rt_asize1": 100,
  "optionValue": -0.4,
  "diffValue": 0.6
}
]

#R语言data.frame对象
df<-data.frame(
  code=c('TF1312','TF1310','TF1313'),
  rt_time=c("152929","152929","152929"),
  rt_latest=c(93.76,93.76,93.76),
  rt_bid1=c(93.76,93.76,93.76),
  rt_ask1=c(90.76,90.76,90.76),
  rt_bsize1=c(2,3,1),
  rt_asize1=c(100,1,11),
  optionValue=c(-0.4,0.2,-0.1),
  diffValue=c(0.6,0.6,0.5)
)

df

#直接使用toJSON，输出的JSON串是按列组合成了数组，并不是我们想要的。
cat(toJSON(df))

#对data.frame进行数据处理，这回就对了，正是我希望的按行输出的结果！！通过alply函数做了变换。
library(plyr)
cat(toJSON(unname(alply(df, 1, identity))))

#4. JSON性能比较
#性能比较我们做2组测试：

#1. rjson和RJSONIO 对大对象进行序列化(toJSON)测试
#2. RJSONIO包，序列化(toJSON) 列式输出和行式输出的测试
#1). rjson和RJSONIO 对大对象进行序列化(toJSON)测试#
#创建一个rjson测试脚本，在命令行启动。
library(rjson)
df<-data.frame(
     a=rep(letters,10000),
     b=rnorm(260000),
     c=as.factor(Sys.Date()-rep(1:260000))
   )
head(df)
system.time(rjson::toJSON(df))
system.time(rjson::toJSON(df))
system.time(rjson::toJSON(df))

#同样，再创建一个RJSONIO测试脚本，在命令行启动。
library(RJSONIO)
df<-data.frame(
  a=rep(letters,10000),
  b=rnorm(260000),
  c=as.factor(Sys.Date()-rep(1:260000))
)
system.time(RJSONIO::toJSON(df))
system.time(RJSONIO::toJSON(df))
system.time(RJSONIO::toJSON(df))
#对比结果发现，rjson的性能优于RJSONIO。

#2). rjson和RJSONIO，序列化(toJSON) 列式输出和行式输出的测试
#创建一个rjson测试脚本，在命令行启动。
library(rjson)
library(plyr)
df<-data.frame(
  a=rep(letters,10000),
  b=rnorm(260000),
  c=as.factor(Sys.Date()-rep(1:260000))
)
system.time(rjson::toJSON(df))
system.time(rjson::toJSON(df))
#system.time(rjson::toJSON(unname(alply(df, 1, identity))))
#system.time(rjson::toJSON(unname(alply(df, 1, identity))))






