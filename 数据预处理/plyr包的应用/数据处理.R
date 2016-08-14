##################plyr包学习############################

xx<- array(1:24,c(3,4,2))
a<-array(1:21,c(3,7))
require(plyr)
library(plyr)

#aaply首字母a表示array； .margins=1(边际)表示对所有数组的行运算
aaply(.data=xx, .margins=1, .fun=mean)

#.margins=2 所有数组的列 进行运算
aaply(.data=xx,  .margins = 2, .fun=mean,  process="text")

####===========================
names=c("john","mary","Alice","Peter","ROger","Phyillis")
age=c(13,15,14,13,14,13)
sex=c("M","F","F","M","M","F")
data=data.frame(names,age,sex)

amean=function(data)
{
  agemean=mean(data[,2])
  return(agemean)
}

#daply首字母d表示dataframe
#.(sex,age) 前面的点表示取data中的列名
daply(data,  .(sex,age), amean)


###========================================
head(mtcars,5)
hp_per_cyl<-function(hp,cyl, ...) hp/cyl
splat(hp_per_cyl)(mtcars[1:5,])
###======================================
each(min,max,var)(rnorm(100))
###======================================
colwise(mean,.(hr,bb))(baseball)
colwise(mean)(baseball)
###=====================================
nmissing<-function(x) sum(is.na(x))
daply(baseball,.(year),colwise(nmissing,is.numeric))
###=========================================
arrange(mtcars,cyl,disp)
###=========================================

freq=count(baseball[1:200,],"id")
arrange(freq,freq)

###==========================================
bb_longterm=match_df(baseball,freq,on="id")

###=========================================
baberuth=subset(baseball,id=="ruthba01")
baberuth
baberuth=transform(baberuth,cyear=year-min(year)+1)

###==============baseball球龄与进球分析==================================
# 建立fun计算每个id的cyear
count_year<-function(df){
  transform(df,cyear=year-min(year)+1)
}
#count_year(baseball[1:100,])
#mapreduce
baseball_cyear<-ddply(baseball,.(id),count_year)
#筛选击球数量大于25次的年份
baseball25=subset(baseball_cyear,ab>=25)
#画图函数
plotpattern<-function(df){
  xlim<-range(baseball25$cyear,na.rm=TRUE)
  ylim<-range(baseball25$rbi/baseball25$ab,na.rm=TRUE)
  qplot(cyear,rbi/ab,data=df,geom="line",xlim=xlim,ylim=ylim)
}
#写入到pdf
pdf("paths2.pdf",width=8,height=4)
d_ply(baseball25,.(id),failwith(NA,plotpattern),.print=TRUE)
dev.off()

####===========
ddply(baseball,.(id),summarise,duration=max(year)-min(year))
###========对所有id'拟合==============================
model<-function(df){lm(rbi/ab~year,data=df)}
allmodels<-dlply(baseball25,.(id),model)
rsq<-function(df){summary(df)$r.squared}
#rsq(allmodels[[1]])
bcoefs<-ldply(allmodels,function(x) c(coef(x),rsquare=rsq(x)))
#直方图
hist(bcoefs$rsquare,breaks=20,col="black")
#拼接
baseballcoef <- join(baseball,bcoefs,by="id",type="inner")
#
match_df(baseballcoef,subset(baseballcoef,rsquare>0.999),on="id")
###==========================================================
value<-ozone[1,1,]
time<-1:72/12

plot(c(1:72),value,main=NULL,xlab="time",ylab="value",type="l")
box(bty="l")
grid(nx=NA,ny=NULL,lty=1,lwd=1,col="gray")
###===========画出每一年的抽样变化折线图================================================
#画出每一年的抽样变化折线图
plot(value[1:12],type="b",pch=19,lwd=2,xaxt="n",col="black",xlab="month",ylab="value")
axis(1,at=1:12,labels=c("Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Dec","Nov"))
lines(value[13:24],col="red",type="b",pch=19,lwd=2)
lines(value[25:36],col="orange",type="b",pch=19,lwd=2)
lines(value[37:48],col="purple",type="b",pch=19,lwd=2)
lines(value[49:60],col="blue",type="b",pch=19,lwd=2)
lines(value[61:72],col="green",type="b",pch=19,lwd=2)
legend("bottomright",
       legend=1995:2000,
       lty=1,lwd=2,pch=rep(19,6),col=c("black","red","orange","purple","blue","green"),
       ncol=1,bty="o",cex=0.5,
       text.col=c("black","red","orange","purple","blue","green"),inset=0.01)
###==============稳健线性回归============================================
month.abbr<-c("Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Dec","Nov")
# 产生因子
month<-factor(rep(month.abbr,length=72),levels=month.abbr)
# 
year<-rep(1:6,each=1)
library("MASS")
deseas1<-rlm(value~month-1)#稳健线性回归
summary(deseas1)
#
plot(coef(deseas1),type="l")

###==对所有24*24进行稳健回归====================================================================
deseasf<-function(value) rlm(value~month-1,maxit = 50)#注意month是字符型因子可以这么用！
models<-alply(ozone,1:2,deseasf)#1:2是提取每个1,2对应的第三维数据
# 用failed储存无法实现稳健线性回归的位置
failed<-laply(models,function(x) !x$converged)#不懂
###====================================================================
coefs<-laply(models,coef) #记录了所有的24*24个位置中每个位置的12个系数dim(coefs)
dimnames(coefs)[[3]]<-month.abbr
names(dimnames(coefs))[3]<-"month"
deseas<-laply(models,resid)#三维向量，记录了所有24*24个位置中每个位置的72个残差
dimnames(deseas)[[3]]<-1:72
names(dimnames(deseas))[3]<-"time"
library("reshape")# 载入reshape包将矩阵转化为df 
coefs_df<-melt(coefs)
coef_df<-ddply(coefs_df,.(lat,long),transform,avg=mean(value))
#coefs<-ldply(models,coef)简单些
###图=============================================================
library("ggplot2")
coef_limits<-range(coefs_df$value)
coef_mid<-mean(coef_df$value)
monthsurface<-function(mon)
{
  df<-subset(coef_df,month == mon)
  qplot(long,lat,data=df,fill=value,geom="tile")+
    scale_fill_gradient(limits=coef_limits,
                        low="lightskyblue",high="yellow")
}
labels=c("Jan","Feb","Mar","Apr","May","June","July","Aug","Sep","Oct","Dec","Nov")
pdf("zone.pdf")
#monthsurface("Jan")
#for (i in labels){
#  print(monthsurface(i))
#}
l_ply(labels,monthsurface,.print=TRUE)
dev.off()