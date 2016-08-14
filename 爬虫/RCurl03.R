#赋值
# 长度、个数： nchar， length
# 替换： chartr（原始字符，替换字符，字符串）
# 连接： paste 参数sep， collapse
# 切割： strsplit
# 比较： >、 <、 ==、 !=
#   并集、交集、补集： union， intersect， setdiff
# 截取：sub; substr， substring
# 匹配： match， pmatch， charmatch
# 搜索： grep
# toupper() 大写转化
# tolower() 小写



setwd("E:/workspace/R/常用代码/爬虫")
##########前半部分###
mychar="dataguru"
list=c("data","guru","rcurl")

chartr("u","r",mychar)
paste("data","guru")
paste(list,collapse='-')

substr(mychar,c(1,2),4)

substring(mychar,c(1,2),c(2,4))

list[1]<list[2]

union(mychar,list)
setdiff(mychar,list)
setdiff(list,mychar)

match("gur",list)
charmatch("gur",list)


(sd)*
  sd   sdsd
s sd  sdddd  sdfsdfg

(da)+
  da  dada  dadada 

.+
  
  d{1,4}
d dd ddd  dddd


pattern="^[A-Za-z0-9\\._%+-]+@[A-Za-z0-9\\.-]+\\.[A-Za-z]{2,4}$"
pattern2="\\w+@\\w+\\.[A-Za-z]{2,4}"
sunshine@163.com

list=c("sunshine@163.com","hujiko","data@jik.kon","kjhfdh@ji.jikol")
> list1
[1] "sunshine@163.com,hujiko,data@jik.kon,kjhfdh@ji.jikol"
grepl(pattern,list)
grep(pattern,list)

list1=paste(list,collapse=",")
gsub(pattern2,"data",list1)


regexec(pattern2,list1)


#####后半部分###
library(RCurl)


http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/603000.phtml?year=2013&jidu=4

temp=getURL("http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/603000.phtml?year=2013&jidu=4")

k=strsplit(temp,"\r\n")[[1]]

timeadr=k[grep("<a target='_blank'",k)+1]

time=substring(timeadr,4,13)

gsub

fpriceadr=k[grep("<a target='_blank'",k)+3]

fprice=gregexpr(">\\d+",fpriceadr)
i=3
for(i in 1:length(fpriceadr))
{
  tempp=fprice[[i]]
  fprices=substring(fpriceadr[i],tempp+1,tempp+attr(tempp,'match.length')+3)
}



pri=getURL("http://hq.sinajs.cn/list=sh603000",.encoding="GBK")


temp=getURL("http://qt.gtimg.cn/r=0.2984983995413796q=marketStat,stdunixtime,usDJI")