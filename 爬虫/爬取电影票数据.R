
## 利用RCurl抓取电影团购信息

library(RCurl)
library(XML)
library("plyr")

#1 抓取的网址是360团购 
#http://tuan.360.cn/dianying
#2 利用firefox的FireBug插件分析其源代码
#page <- 1:5
#urlist[page]  <- paste("http://tuan.360.cn/bei_jing/c_0.html?kw=电影&pageno=",page,"#tuanFilter",sep="")
urlist  <- paste("http://tuan.360.cn/dianying")
#伪造报头
#下面这个是伪装成windows登陆火狐浏览器浏览
myheader=c("User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
           "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
           "Accept-Language"="en-us",
           "Connection"="keep-alive",
           "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)

#相当于定义了这些变量为字符型变量
#电影院名称
dyy_name<-c("")
#原价
last_price<-c("")
#优惠价格
now_price<-c("")
#售出的票数
much<-c("")
#来源
tg_source<-c("")



#for(url in urlist){
  #下载网址
  #webpage  <- getURL(url,httpheader=myheader,.encoding="utf-8")

#curl部分参数设置
#  verbose：输出访问的交互信息
#  httpheader：设置访问信息报头
# .encoding=“UTF-8””GBK”
#  debugfunction,headerfunction,curl
# .params：提交的参数组
# dirlistonly：仅读取目  #ftp.wcc.nrcs.usda.gov/data/snow/snow_course/table/history/idaho/
# followlocation：支持重定向   http://www.sina.com
# maxredirs：最大重定向次数

  webpage  <- getURL(urlist,httpheader=myheader,.encoding="utf-8")
  #转化成XML格式
  pagetree <- htmlTreeParse(webpage,encoding="utf-8", 
                            error=function(...){}, 
                            useInternalNodes = TRUE,trim=TRUE)
  #利用XPATH筛选
  #/： 表示选择根节点
  #//： 表示选择任意位置的某个节点
  #@： 表示选择某个属性
  #*表示匹配任何元素节点。
  #@*表示匹配任何属性值。
  
  #"//*/span [@class='main-title']" 匹配电影院名称
  temp_name <- xpathSApply (pagetree, "//*/span [@class='main-title']", xmlValue)
  dyy_name<-c(dyy_name,temp_name)

  #"//*/span [@class='discount']" 匹配原价
  
  temp_price <- xpathSApply (pagetree, "//*/span [@class='discount']",xmlValue)[]
  last_price<-c(last_price,temp_price)
  #last_price[1]
  
  #"//*/span [@class='price']" 匹配优惠价
  temp_now_price <- xpathSApply (pagetree, "//*/span [@class='price']",xmlValue)
  now_price<-c(now_price,temp_now_price)
  
  #"//*/div [@class='btn-item']" 匹配售出多少张票
  temp_much <- xpathSApply (pagetree, "//*/div [@class='btn-item']",xmlValue)
  much<-c(much,temp_much)
  
  #影片来源
  #temp_tg_source <- xpathSApply (pagetree, "//*/div [@class='source clearfix']", xmlValue)
  #tg_source<-c(tg_source,temp_tg_source)
  #tg_source[2]
#}
  
  # 删除不必要的信息
  tg_name<-laply(as.list(dyy_name),function(x){
    unlist(strsplit(x,"，"))[1]
  })
  
# 删除不必要的信息
#  tg_source<-laply(as.list(tg_source),function(x){
#    unlist(strsplit(x,"\n"))[2]
#  })

# 删除不必要的信息
much_la<-laply(as.list(much),function(x){
  x2 = unlist(strsplit(x,"\t\t\t"))[2]
  #\s表示空格 \ 表示转义符号
  unlist(strsplit(x2,"\\s"))[30]
})
#组装成数据库
content<-data.frame(tg_name,last_price,now_price,much_la)[-1,]
names(content)<-c('影院','原价','优惠价','售出张数')

#写入csv文件
write.csv(content,file="电影团购信息.csv")
