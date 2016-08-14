#############################
#verbose：输出访问的交互信息
# httpheader：设置访问信息报头
# .encoding=“UTF-8””GBK”
# debugfunction,headerfunction,curl
# .params：提交的参数组
# dirlistonly：仅读取目录
#   ftp.wcc.nrcs.usda.gov/data/snow/snow_course/table/history/idaho/
#   followlocation：支持重定向
# http://www.sina.com  
# maxredirs：最大重定向次数

############################
setwd("E:/workspace/R/常用代码/爬虫")
library(RCurl)

url="ftp.wcc.nrcs.usda.gov/data/snow/snow_course/table/history/idaho/"
url.exists(url)
curl = getCurlHandle()
#dirlistonly = T：仅读取目录, 在ftp：//上使用比较出色
#把每个目录的名字读下来
filenames = getURL(url, dirlistonly = TRUE)
#查看响应信息，是否成功登陆
getCurlInfo(curl)$response.code



#收集下面要访问的链接的信息
curl = getCurlHandle()
#新浪的错误地址，显示页面永久性移除 无法访问
destination = getURL("http://www.sina.com", curl = curl)

#如果想从旧的地址访问得到新的地址，用参数 followlocation：支持重定向
#就能得到所要的信息
destination = getURL("http://www.sina.com", curl = curl, followlocation = T)
#这个才是正确地址
destination=getURL("http://www.sina.com.cn", curl = curl)
#链接中的信息传递给了空的getCurlHandle() ,然后用getCurlInfo()读取这些信息
getCurlInfo(curl)$response.code


#######################################################
#网页中有下载的文件，用查看源代码的方式，找到这个下载文件的网址，即下列的网址
#用getBinaryURL 下载文件
url="http://job.abchina.com/abb/download_accessory.do?action=accessory&pronunciamentoId=46702"
url.exists(url)
temp<- getBinaryURL(url)
#最好保存为xls文件
#将文件以二进制的方式(wb)打开一个空文件hellodata.xls
note <- file("hellodata.xls",open = "wb" )
#用writeBin()将下载的文件temp写入note中
writeBin(temp,note)
#关闭把文件
close(note)
##############################################

################################################
#获得系统时间                   
time = Sys.time()
class(time)
#time是 "POSIXct" "POSIXt" 类型的数据，不能直接分隔
strsplit(time, " ")

#要转化为字符型，转化之后 后面的CST就没有了，它是标识时间类型的
as.character(Sys.time())
#中间没有空格，每个字符都被分隔出来
strsplit(as.character(Sys.time()),'')
#有空格就按空格分隔
strsplit(as.character(Sys.time()),' ')
strsplit(as.character(Sys.time()),' ')[2]
#strsplit()是将时间分隔后按照数组形式存储，因此unlist将数组转化为向量
unlist(strsplit(as.character(Sys.time()),' '))
unlist(strsplit(as.character(Sys.time()),' '))[2]

#################################################


###################################################
#########################批量下载文件
#getURL是将网页源代码读取成一个字符串向量
html=getURL("http://rfunction.com/code/1202/")
url.exists(html)
#<li><a href=\"作为切割符，转义的是单个引号，作为分隔
temp =strsplit(html, "<li><a href=\"")[[1]]
#再以\"作为分隔符，即单个引号作为分隔符
files =strsplit(temp, "\"")

#去列表的中每一列第一维的数据
files=lapply(files, function(x){ x[1] })
files= unlist(files)
files = files[-(1:2)]#得到要下载的文件名

baseURL="http://rfunction.com/code/1202/"
for(i in 1:length(files)){
  #构建要处理的链接，不要空格
  URL = paste(baseURL, files[i], sep="")
  #对链接中的数据进行抓取，该函数只对连接中含有数据
  bin <- getBinaryURL(URL)
  #把下载的文件分别放到一些文件中
  #如果要放在同一个文件里，为了防止被替换，可以在file()中添加 append = T,防止替换
  con <- file(paste("1202", files[i], sep="."), open = "wb")
  #将前面的连接数据写入到后面的文件中
  writeBin(bin, con)
  close(con)
  #每两秒中运行一次循环，防止下载过于频繁被网站踢出
  Sys.sleep(2) 
}



##########第一段视频↑######
##########第二段视频↓######
#XML包网页解析工具
# 表格
# 网页节点
# 对标准 XML 文件的解析函数 xmlParse
# 对html的解析函数 htmlTreeParse
# 缺点： windows下对中文的支持不理想
library(RCurl)
library(XML)

#######抓取表格数据
url="http://www.bioguo.org/AnimalTFDB/BrowseAllTF.php?spe=Mus_musculus"
url.exists(url)
wp<-getURL(url)
#htmlParse对页面解析,
doc <-htmlParse(wp, asText= TRUE)
#readHTMLTable将table数据存储为列表形式,which表示第几个列表
tables <-readHTMLTable(doc ,which=5)
head(tables)



####抓取地震数据
url="http://219.143.71.11/wdc4seis@bj/earthquakes/csn_quakes_p001.jsp"
url.exists(url)
wp<-getURL(url)
doc <-htmlParse(wp, asText= TRUE)
tables <-readHTMLTable(doc)
head(tables)
#header=F 跳过页眉解析，在windows系统会出现解析中文字体错误，最好在Linux系统下操作
tables <-readHTMLTable(doc,header=F, which = 2)
head(tables)


##########################################
#xml文件
url="http://www.w3school.com.cn/example/xmle/books.xml"
url.exists(url)
#解析xml文件
doc<-xmlParse(url)

##############################################
#斜杠（ /）作为路径内部的分割符。
# /： 表示选择根节点
# //： 表示选择任意位置的某个节点
# @： 表示选择某个属性
# *表示匹配任何元素节点。
# @*表示匹配任何属性值。
# node()表示匹配任何类型的节点。
###########################################
#下面的斜杠(/)为根节点(bookstore为根节点， book是这个跟节点中的一个子节点)；
#[1]表示取出根节点的第一个子节点
getNodeSet(doc, '/bookstore/book[1]')
#取得最后一个子节点
getNodeSet(doc, '/bookstore/book[last()]')
#抓取前两个节点
getNodeSet(doc, '/bookstore/book[position()<3]')

#通过每个子节点的属性抓取子节点下面属性包含的信息
#<title lang="en">Harry Potter</title>
#用中括号将语言(lang)这个属性作为一个整体，并用@指名lang是一个属性
#
getNodeSet(doc, '//title[@lang]')
#<price>29.99</price>
getNodeSet(doc, '//book/price')
#|表示或的逻辑符，多个并列路径
getNodeSet(doc,'//title[@lang]|//book/price')



###################################################################
#抓取电影团购数据

#伪装报头
myheader <- c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)

#用getURL中的参数要包含报头，和字符utf-8
#d = debugGatherer()#不是动态网页这里就不用这个函数
#d$value()

##############################################################
####先分析一个网页数据

temp=getURL("http://t.dianping.com/movie/beijing/tab_deal?pageno=1",
            httpheader=myheader,
            .encoding = "UTF-8"
 #           debugfunction=d$update,
 #           verbose =TRUE
 )

#cat(d$value()[1])#服务器地址以及端口号
#cat(d$value()[2])#服务器端返回给客户端的头信息
#cat(d$value()[3])#客户端提交给服务器的头信息

#解析网页
k=htmlParse(temp)

getNodeSet(k,'//div [@class="tg-floor-item-wrap"]')

# <div class="tg-floor-item-wrap">
youhui=sapply(getNodeSet(k,'//div[@class="tg-floor-item-wrap"]'),xmlValue)
you_str = strsplit(youhui, "\n")
you_fei = lapply(you_str, function(x) {x[c(5,6,10,13,17)]})

#折扣价  sub() 替换函数 
#.表示任意字符；\s表示空字符(小s)，(大S非空字符)；
#[m1m2]中括号将m1m2括起来表示，组成一个字符串进行匹配
#匹配它前面的字符：+ 表示一次或多次匹配；*零次或多次匹配；？零次或一次匹配


#电影院
dianyingyuan = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[1])}))
#售价信息
xinxi = unlist(lapply(you_fei, function(x){sub('\\s+', '', x[2])} ))
#折扣价
shoujia = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[3])}))
#原价
yuanjia = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[4])}))
#已出售票数
piaoshu = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[5])}))

data = data.frame("电影院地址" = dianyingyuan, 
                  "售价" = shoujia, 
                  "原价" = yuanjia, 
                  "已售出票数"=piaoshu, 
                  "备注" = xinxi
                  )

head(data)
#EXCEL2007要用"UTF-16LE"
write.csv(data,"电影团.csv")




###################################################################
#抓取多个页面的数据

#构建抓取网页数据函数
tuangou = function(url, i){
  
  myheader <- c(
    "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
    "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language"="en-us",
    "Connection"="keep-alive",
    "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
  )
  
  #url = "http://t.dianping.com/movie/beijing/tab_deal?pageno=2"
  temp=getURL(url, httpheader=myheader,  .encoding = "UTF-8")

  #解析网页
  k=htmlParse(temp)
  
  #获得节点
  #getNodeSet(k,'//div [@class="tg-floor-item-wrap"]')
  
  #处理每个节点
  youhui=sapply(getNodeSet(k,'//div[@class="tg-floor-item-wrap"]'),xmlValue)
  #分隔节点
  you_str = strsplit(youhui, "\n")
  #取得有用的数据
  you_fei = lapply(you_str, function(x) {x[c(5,6,10,13,17)]})
  
  #电影院
  dianyingyuan = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[1])}))
  #售价信息
  xinxi = unlist(lapply(you_fei, function(x){sub('\\s+', '', x[2])} ))
  #折扣价
  shoujia = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[3])}))
  #原价
  yuanjia = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[4])}))
  #已出售票数
  piaoshu = unlist(lapply(you_fei, function(x) {sub('\\s+', '', x[5])}))
  
  data = data.frame("电影院地址" = dianyingyuan, 
                    "售价" = shoujia, 
                    "原价" = yuanjia, 
                    "已售出票数"=piaoshu, 
                    "备注" = xinxi)
  
  dianying = paste("电影团购", i,".csv", sep = "")
  write.csv(data, dianying)
  
}



urllist=0
i=0
page=1:3
urllist[page]=paste("http://t.dianping.com/movie/beijing/tab_deal?pageno=", page , sep='')
for(url in urllist)
{
    i = i+1
    tuangou(url, i)
    Sys.sleep(2)
}


