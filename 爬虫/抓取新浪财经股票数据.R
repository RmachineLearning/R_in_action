library(RCurl)
library(XML)
library(plyr)

#伪装报头
myheader<-c("User-Agent"="Mozilla/5.0 (Windows; U; Windows NT 5.1; zh-CN; rv:1.9.1.6) ",
            "Accept"="text/html,application/xhtml+xml,application/xml;q=0.9,*form[@name="daily"]/select[@na   me="year"]/option',xmlValue"
            years<-as.numeric(years) 
            minYear<-min(years)
            maxYear<-max(years)
            #提取个股历史交易数据时，给出年度区间的提示
            if(year.startmaxYear){
            stop("invalid time interval,max year is\t",maxYear,"min year is\t" ,minYear)
            }
            }
            
            
            readTable<-function(url,myheader){
            force(url)
            webpage<-getURL(url,httpheader=myheader,.encoding="UTF-8");
            pagetree<-htmlTreeParse(webpage,encoding="UTF-8",
            error=function(...){},useInternalNodes=TRUE,trim=F) 
            table<-readHTMLTable(pagetree,header=F)
            table<-table$FundHoldSharesTable[-c(1,2),]
            n<- nrow(table)
            table[rev(1:n),]
            }
            
            
            getSingleInfo.TQ<-function(page,myheader){
            force(page) #把page设为函数参数
            pages<-paste(page,"&jidu=",1:4,sep="")
            ldply(pages,failwith(f=readTable,quiet=T),myheader)
            } 
            
            #设置读取全部数据的函数
            getAllInfo.TQ<-function(code,year.start,year.end,myheader,path){
            verifyYears(code,year.start,year.end,myheader)
            years=seq(from=year.start,to=year.end,by=1);
            urls<-paste("http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/",
            code,".phtml?year=",years,sep="");
            res<-ldply(urls,getSingleInfo.TQ,myheader,.progress="win")
            names(res)<-c("date","open","high","close","low","volume","total_pay")
            write.csv(res,path)
            }
            
            #填入个股代码，起始与截至年度，自动导出csv
            getAllInfo.TQ(code="600000",year.start=2010,year.end=2014,myheader,"spdb.csv")