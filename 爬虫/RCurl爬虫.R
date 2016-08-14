
setwd("E:/workspace/R/常用代码/爬虫")
library(RCurl)

#判断网页是否存在
url.exists("http://www.baidu.com")

###############################################################

#伪装header头信息，就是为了防止网站察觉到是有爬虫来获取信息的
##下面这个是伪装成windows登陆火狐浏览器,提交下面的信息给服务器，
#然后服务器接受了这些信息，会返回一个响应信息，这个响应信息用debugGatherer()获得
myheader <- c(
  "User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
  "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language"="en-us",
  "Connection"="keep-alive",
  "Accept-Charset"="GB2312,utf-8;q=0.7,*;q=0.7"
)

#在没有伪装头头信息时(就是没有提交客户端请求时访问服务器端)客户端能提交的信息
#服务器端反馈给客户端(浏览器端)的信息
#debugGatherer()中包含来自HTTP的响应信息，
#在动态网页上使用该函数并设置update，就可以实时访问动态网页
#包含状态行;消息报头;响应正文 包含在 value中
#update 用来跟踪 动态网页
#查看header是否伪装成功(header 是否已经提交上去了)
d = debugGatherer()
d$value()
temp <- getURL("http://www.dataguru.cn/",
               httpheader = myheader,
               debugfunction=d$update,
               verbose =TRUE)
cat(d$value()[1])#服务器地址以及端口号
cat(d$value()[2])#服务器端返回给客户端的头信息
cat(d$value()[3])#客户端提交给服务器的头信息

######################################################
#查看RCurl系统参数信息,一共有170个
names(getCurlOptionsConstants())

##########################################
#getForm用来做搜索
wangye = "https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&tn=sitehao123&wd=RCurl&rsv_pq=da9cc0e900002b3e&rsv_t=259epf8EriexZ%2BBZqNgP0OLqTB6cvNAoPESiSn3z8LSnmaQ2jHMfVD76sLy%2F9v03Jg&rsv_enter=1&rsv_sug3=13&rsv_sug1=13&rsv_sug2=0&inputT=7148&rsv_sug4=7149"
#分析这个网址由哪几部分组成
getFormParams(wangye)

url = getForm("http://www.baidu.com/s", "wd"="RCurl")



#有这么多参数要设置，可以用cRUL handles()来处理
#cRUL handles可根据客户端、 服务器端参数的设定在动态的变化， 随时更新内容

#定义了一个最基本的cRUL handles：
cHandle <-  getCurlHandle(httpheader =  myheader)

#在getURL中可以如下应用：
d = debugGatherer()
temp <-  getURL("http://cos.name/",
                .opts =list(debugfunction=d$update,verbose = TRUE), 
                curl=cHandle)
#此时， cHandle中的cRUL系统参数debugfunction、 verbose均发生及时的更新。

#############################################################
#用Rculr实现登陆

#首先查看用浏览器正常登陆时，客户端提交给服务器端的信息， 然后照葫芦画一个。
#访问http: //cos.name/bbs/login.php?
#用foxfire 的header插件查看提交的头信息
#这个头信息的核心就是客户端用POST方法给这个网址提交了一个字符串（即头信息
#最后的两行， 其中包含了你的用户名和密码）请求服务器端给予身份认证。 
#如果要让RCurl提交相同的字符串， 需要将上面的那段关键字
#符串转变成如下的格式：c(name1=”info1”,name2=”info2”,…)
myPost <- function(x){
  post = scan(x,what="character",quiet=TRUE,sep="\n")
  abcd = strsplit(post,"&")[[1]]
  abc = gsub("(^.*)(=)(.*$)","\\3",abcd)
  abcnames = gsub("(^.*)(=)(.*$)","\\1",abcd)
  names(abc) = abcnames
  return(abc)
  
}

postinfo <- myPost("clipboard")

#然后用RCurl中的postForm函数，将postinfo提交给服务器：
url.exists("http://cos.name/bbs/login.php?")

temp <- postForm("http://cos.name/bbs/login.php?",.params=postinfo,
                 .opts=list(cookiefile=""),curl=cHandle,style="post")

#用查看一下cos.name给你的客户端反馈了那些内容？作为登录认证的cookies是不是已经在里面了？
cat(d$value()[2])

#到这一步，RCurl已经成功的登录到http://cos.name/bbs/了，需要的一切认证信息都已经记录到百宝箱cHandle中了。用
getCurlInfo(cHandle)[["cookielist"]]

#看看你想要的cookie是不是在那里了？接着用cHandle登录一下R子论坛吧，验证一下你是否真正的成功了？

temp <- getURL("http://cos.name/bbs/thread.php?fid=15",
               curl=cHandle,.encoding="gbk")

#################################################################
#如果不能用上面的方法来完成RCurl登录认证
#所谓的认证信息一般就是服务器端在你的浏览器里面写下的cookies，
#把他们导出来交给RCurl，RCurl同样可以做好你需要的cURL handle

#先用你的常规浏览器（此处假定为Firefox）正常登录到http://cos.name/bbs/，
#然后再用Firefox的扩展Firecookie看看当前页面的cookie信息：你需要的就是它们了。
#将这些cookie信息导出成RCurl能够识别的格式，然后提交给RCurl就万事大吉了。

###########################################################
#############查看服务器返回的头信息
#头信息包含
#Host; Accept; Accept-encoding; Accept-languag; User-agent
# Cookie; Referer; Connection

#以字符串形式展示服务器返回的头信息(response header)
headers = basicTextGatherer()
txt=getURL("http://www.dataguru.cn/",headerfunction = headers$update)
names(headers$value())#说明是字符串形式
headers$value()

#以列表形式展示服务器返回的头信息(response header)
h = basicHeaderGatherer()
txtt=getURL("http://cos.name/cn/topic/411708/",headerfunction = h$update)
names(h$value())
h$value()
###############################################################
##################查看curl请求的访问信息
curl = getCurlHandle()
d=getURL("http://cos.name/cn/topic/411708/", curl = curl)
getCurlInfo(curl)$response.code
getCurlInfo(curl)
##########################

d2 = debugGatherer()
cHandle2 <- getCurlHandle(httpheader=myHttpheader,
                          followlocation=1,
                          debugfunction=d2$update,
                          verbose=TRUE,
                          cookiefile="yourcookiefile.txt")

#接着去cos.name的R论坛看看：
temp <- getURL("http://cos.name/bbs/thread.php?fid=15",
               curl=cHandle2,
               .encoding="gbk")

#验证一下temp里面是不是已经有你的大名了呢？
#如果有的话那么恭喜你：RCurl已经成功接管你的登录权限了。
grep("yourname",temp)





################################################################
#一个例子
url = getURL("http://rfunction.com/code/1202/")
# getBinaryURL()批量下载文件
temp<- getBinaryURL(url)
note <- file("hellodata.xls", open = "wb")
writeBin(temp,note)
close(note)

#################################################
#getForm 用来搜索







#################################################
#抓取网页表格数据
library(XML)
wp = getURL("http://www.bioguo.org/AnimalTFDB/BrowseAllTF.php?spe=Mus_musculus")
doc <- htmlParse(wp, asText = TRUE)
tables <- readHTMLTable(doc)
head(tables$table1)

###############################################
#抓取地震数据
dizhen = getURL("http://data.earthquake.cn/datashare/datashare_more_quickdata_new.jsp")
dizhen_doc <-htmlParse(dizhen, asText = TRUE)
dizhen_tables <- readHTMLTable(dizhen_doc,header=F)
head(dizhen_tables)


























