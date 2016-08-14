require(XML)
require(RCurl)
#第二步：抓取网页的源代码。
#只需要知道网址就OK了。程序包RCurl能自动为你做。命令两三行：
webpage<-getURL(link)
webpage <- readLines(tc <- textConnection(webpage));
close(tc)
pagetree <- htmlTreeParse(webpage, error=function(...){}, useInternalNodes = TRUE)

#第三步：选定表格。
#网页上肯定不止一个表格，要什么样的，用html语言@限定
#这里是抓表格的标题。“”中是html语言;＃这里是抓表格的标题。
tablehead <- xpathSApply(pagetree, "//table//th", xmlValue) 
#这里是表格内容。
result<-xpathSApply(pagetree,"//table//td",xmlValue) 


